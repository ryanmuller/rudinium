Rudini.Views.Items ||= {}

class Rudini.Views.Items.ItemView extends Backbone.View
  template: JST["backbone/templates/items/item"]

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
