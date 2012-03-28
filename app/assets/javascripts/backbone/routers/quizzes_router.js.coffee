class Rudini.Routers.QuizzesRouter extends Backbone.Router
  initialize: (options) ->
    @quizzes = new Rudini.Collections.QuizzesCollection()
    @quizzes.reset options.quizzes

  routes:
    "/new"      : "newQuiz"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newQuiz: ->
    @view = new Rudini.Views.Quizzes.NewView(collection: @quizzes)
    $("#quizzes").html(@view.render().el)

  index: ->
    @view = new Rudini.Views.Quizzes.IndexView(quizzes: @quizzes)
    $("#quizzes").html(@view.render().el)

  show: (id) ->
    quiz = @quizzes.get(id)

    @view = new Rudini.Views.Quizzes.ShowView(model: quiz)
    $("#quizzes").html(@view.render().el)

  edit: (id) ->
    quiz = @quizzes.get(id)

    @view = new Rudini.Views.Quizzes.EditView(model: quiz)
    $("#quizzes").html(@view.render().el)
