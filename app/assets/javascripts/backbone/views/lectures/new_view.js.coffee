Rudini.Views.Lectures ||= {}

class Rudini.Views.Lectures.NewView extends Backbone.View
  template: JST["backbone/templates/lectures/new"]

  events:
    "submit #new-lecture": "save"

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
      success: (lecture) =>
        @model = lecture
        window.location.hash = "/#{@model.id}"

      error: (lecture, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
