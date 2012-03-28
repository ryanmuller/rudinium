Rudini.Views.Quizzes ||= {}

class Rudini.Views.Quizzes.ShowView extends Backbone.View
  template: JST["backbone/templates/quizzes/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
