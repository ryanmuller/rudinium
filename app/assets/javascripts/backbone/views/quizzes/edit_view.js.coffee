Rudini.Views.Quizzes ||= {}

class Rudini.Views.Quizzes.EditView extends Backbone.View
  template : JST["backbone/templates/quizzes/edit"]

  events :
    "submit #edit-quiz" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (quiz) =>
        @model = quiz
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
