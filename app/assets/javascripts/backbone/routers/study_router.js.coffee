class Rudini.Routers.StudyRouter extends Backbone.Router

  # initialize study router; 
  # load quizzes and memories as collections.
  # Object assigned to RudiniApp.study, and so memories/quizzes collections
  # can be accessed at RudiniApp.study.memories and RudiniApp.study.quizzes
  initialize: (options) ->
    @quizzes = new Rudini.Collections.QuizzesCollection()
    @quizzes.reset options.quizzes

    @memories = new Rudini.Collections.MemoriesCollection()
    @memories.reset options.memories


  # do we want to have a route to show specific quiz...?
  routes:
    "/study"      	: "index"	# start studying

  # displays the nth quiz in a batch.
  showNthQuiz: (n) ->
    $('.quiz').hide()
    $('.quiz:nth('+n+')').show()
    $('.revealed').removeClass('revealed')
  
    # fix the text
    $('#nth-quiz').text(n+1)
  
    # render 
    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"quiz-container"])
  
    # fix the buttons to page through quizzes on particular item memory
    $('#quiz-show-btn').removeClass('disabled')
    if n == 0
      $('#quiz-back-btn').addClass('disabled')
    else
      $('#quiz-back-btn').removeClass('disabled')
  
    if n == parseInt($('#nth-quiz').attr('data-total'))-1
      $('#quiz-next-btn').addClass('disabled')
    else
      $('#quiz-next-btn').removeClass('disabled')

     
  # loads the next "due" memory from the memories collection...
  loadNextMemory: () ->
    memory = @memories.find((model) ->
      return model.get("due") == true)
    
    # if there are no "due" memories, load the null memory
    # (aka, 'you're done studying!')
    if memory == undefined
      this.show(null)
    else
      this.show(memory.id) 
      
 
  # show memory + associated quizzes
  # id: memory_id
  show: (id) ->
    $("#item-container").hide()
    $("#study-container").show()

    # if no memory_id, display "done studying" message.
    if id == null
      $("#quiz-container").html("<p>You don't have anything to study, congrats!</p>")
      $("#rating-panel").html("")
      return false
    
    # else, load up memory by id, and display quizzes + rating panel
    memory = RudiniApp.study.memories.get(id) 
    @quiz = new Rudini.Views.Quizzes.ShowView(model: memory)
    $("#quiz-container").html(@quiz.render().el)
    
    @rating = new Rudini.Views.Memories.RatingView(model: memory)
    $("#rating-panel").html(@rating.render().el)
    this.showNthQuiz(0)

    # bind click events to page thorugh quizzes...
    controller = this
    $('#quiz-back-btn').click(() ->
      return if $(this).hasClass('disabled')
      controller.showNthQuiz(parseInt($('#nth-quiz').text())-2)
    )
   
    $('#quiz-next-btn').click(() ->
      return if $(this).hasClass('disabled')
      controller.showNthQuiz(parseInt($('#nth-quiz').text()))
    )
  
    $('#quiz-show-btn').click(() ->
      return if $(this).hasClass('disabled')

      $('#item-content').show()
      $(this).addClass('disabled')
  
      # remove blanks on the correct quiz
      $('.blank').addClass('revealed')
    )
  
  # start studying.
  # First, renders the sidebar/page and fetches latest memory data
  # from the server. Then calls loadNextMemory to start studying!
  index: ->
    document.title = "LSRu - Study"
    RudiniApp.items.renderSidebar()
    study = this
    @memories.fetch({success: (data) ->
      study.loadNextMemory()})
