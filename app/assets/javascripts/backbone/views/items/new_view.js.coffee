Rudini.Views.Items ||= {}

class Rudini.Views.Items.NewView extends Backbone.View
  template: JST["backbone/templates/items/new"]

  events:
    "submit #new-item": "save"

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
      success: (item) =>
        @model = item
        window.location.hash = "/#{@model.id}"

      error: (item, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
