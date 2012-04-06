Rudini.Views.Page ||= {}

class Rudini.Views.Page.PageView extends Backbone.View
  template: JST["backbone/templates/page/page"]

  className: "row"

  render: =>
    $(@el).html(@template())

    return this
