Rudini.Views.Items ||= {}

class Rudini.Views.Items.HelpView extends Backbone.View
  template: JST["backbone/templates/items/help"]


  render: ->
    $(@el).html(@template(@model))
    return this
