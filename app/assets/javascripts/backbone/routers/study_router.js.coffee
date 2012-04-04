# window.study
class Rudini.Routers.StudyRouter extends Backbone.Router
  initialize: (options) ->
    # initialize study router; load quizzes collection
    # the relevant memories will be pulled from server 
    # in the index action.
    @quizzes = new Rudini.Collections.QuizzesCollection()
    @quizzes.reset options.quizzes



  routes:
    "/study/:id"      	: "showQuiz" 	# show specific quiz
    "/study"      	: "index"	# start studying


  showQuiz: (id) ->
    if id == null
      $("#item-container").hide()
      $("#quiz-container").show()
      $("#quiz-container").html("<p>You don't have anything to study, congrats!</p>")
      return false
      
    quiz = @quizzes.get(id)
    console.log('quiz show' + id)

    @view = new Rudini.Views.Quizzes.ShowView(model: quiz)
    @ratings = new Rudini.Views.Quizzes.RatingView(model: quiz)
    $("#item-container").hide()
    $("#quiz-container").show()
    $("#quiz-container").html(@view.render().el)
    $("#rating-panel").html(@ratings.render().el)


    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"quiz-container"])


  index: ->
    window.items.renderPage()
    window.items.renderSidebar()

    RudiniApp.studying = new Rudini.Collections.Memories()
    $.getJSON("/spaceable_memories", (data) ->
      RudiniApp.studying.reset data
      if data.length > 0
        window.studying.popQuiz()
        memoryObject = window.studying.popQuiz()
        quizzes.runMemory(memoryObject.memory)
      else
        quizzes.show(null)
    )
  
  runMemory: (memory) ->
    m = memory.attributes
    if m.quizzes.length > 0
      quizzes.show(m.quizzes[0])
    else
        $("#item-container").hide()
        $("#quiz-container").show()
        $("#quiz-container").html("<p>noQuiz<a href='#' class='next'>next</a></p>")
      
    









