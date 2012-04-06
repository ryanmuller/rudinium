# window.study
class Rudini.Routers.StudyRouter extends Backbone.Router
  initialize: (options) ->
    # initialize study router; 
    # load quizzes and memories
    # the memories/due_memories can get updated from server
    @quizzes = new Rudini.Collections.QuizzesCollection()
    @quizzes.reset options.quizzes

    @memories = new Rudini.Collections.MemoriesCollection()
    @memories.reset options.memories


  update: () ->
    # updates memories
    memories = @memories
    due = @due
    $.getJSON("/spaceable_memories/memories", (data) ->
      memories.reset data)
    $.getJSON("/spaceable_memories/due", (data) ->
      due.reset data)
     


  routes:
    "/study/:id"      	: "showQuiz" 	# show specific quiz
    "/study"      	: "index"	# start studying

  showNthQuiz: (n) ->
    $('.quiz').hide()
    $('.quiz:nth('+n+')').show()
    $('.revealed').removeClass('revealed')
  
    # fix the text
    $('#nth-quiz').text(n+1)
  
    # render 
    # ... still necessary?
    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"quiz-container"])
  
    # fix the buttons
    $('#quiz-show-btn').removeClass('disabled')
    if n == 0
      $('#quiz-back-btn').addClass('disabled')
    else
      $('#quiz-back-btn').removeClass('disabled')
  
    if n == parseInt($('#nth-quiz').attr('data-total'))-1
      $('#quiz-next-btn').addClass('disabled')
    else
      $('#quiz-next-btn').removeClass('disabled')
     
  loadNextMemory: () ->
    console.log('loading next memory')
 
    memory = @memories.find((model) ->
      return model.get("due") == true)
    
    if memory == undefined
      this.show(null)
    else
      this.show(memory.id) 
      
 
  # show memory + associated quizzes
  # id: memory_id
  show: (id) ->
    console.log('showing memory... ' + id)
    $("#item-container").hide()
    $("#study-container").show()
    if id == null
      $("#quiz-container").html("<p>You don't have anything to study, congrats!</p>")
      return false
    
    memory = RudiniApp.study.memories.get(id) 
    console.log(memory)

    @quiz = new Rudini.Views.Quizzes.ShowView(model: memory)
    $("#quiz-container").html(@quiz.render().el)
    
    @rating = new Rudini.Views.Memories.RatingView(model: memory)
    $("#rating-panel").html(@rating.render().el)
    this.showNthQuiz(0)

    #fix the buttons...
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
  
  


  index: ->
    #check to see if these are rendered...?
    RudiniApp.items.renderPage()
    RudiniApp.items.renderSidebar()
  
    this.loadNextMemory()
