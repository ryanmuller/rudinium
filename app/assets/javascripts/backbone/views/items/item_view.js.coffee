Rudini.Views.Items ||= {}

class Rudini.Views.Items.ItemView extends Backbone.View
  template: JST["backbone/templates/items/item"]


  tagName: "li"


  render: ->
    
    $(@el).html(@template(@model.toJSON() ))
    $(@el).attr('id', 'nav-item-' + @model.attributes.id)
    return this
