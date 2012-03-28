Rudini.Views.Quizzes ||= {}

class Rudini.Views.Quizzes.QuizView extends Backbone.View
  template: JST["backbone/templates/quizzes/quiz"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
