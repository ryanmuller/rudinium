class Rudini.Views.Items.KoanView extends Backbone.View
  template: JST["backbone/templates/items/koan"]

  render: ->
    $(@el).html(@template({model: @model}))

    return this
