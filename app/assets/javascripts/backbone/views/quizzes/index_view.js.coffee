Rudini.Views.Quizzes ||= {}

class Rudini.Views.Quizzes.IndexView extends Backbone.View
  template: JST["backbone/templates/quizzes/index"]

  initialize: () ->
    @options.quizzes.bind('reset', @addAll)

  addAll: () =>
    @options.quizzes.each(@addOne)

  addOne: (quiz) =>
    view = new Rudini.Views.Quizzes.QuizView({model : quiz})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(quizzes: @options.quizzes.toJSON() ))
    @addAll()

    return this
