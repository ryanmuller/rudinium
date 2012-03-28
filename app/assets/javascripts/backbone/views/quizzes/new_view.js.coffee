Rudini.Views.Quizzes ||= {}

class Rudini.Views.Quizzes.NewView extends Backbone.View
  template: JST["backbone/templates/quizzes/new"]

  events:
    "submit #new-quiz": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (quiz) =>
        @model = quiz
        window.location.hash = "/#{@model.id}"

      error: (quiz, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
