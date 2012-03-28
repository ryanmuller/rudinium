Rudini.Views.Items ||= {}

class Rudini.Views.Items.PageView extends Backbone.View
  template: JST["backbone/templates/items/page"]

  className: "row"


  initialize: () ->
    @options.items.bind('reset', @addAll)

  render: =>
    $(@el).html(@template())

    return this
