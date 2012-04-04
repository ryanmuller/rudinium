Rudini.Views.Page ||= {}

class Rudini.Views.Page.PageView extends Backbone.View
  template: JST["backbone/templates/page/page"]

  className: "row"


  initialize: () ->
    @options.items.bind('reset', @addAll)

  render: =>
    $(@el).html(@template())

    return this
