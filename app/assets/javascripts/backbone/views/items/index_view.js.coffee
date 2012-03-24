Rudini.Views.Items ||= {}

class Rudini.Views.Items.IndexView extends Backbone.View
  template: JST["backbone/templates/items/index"]

  initialize: () ->
    @options.items.bind('reset', @addAll)

  addAll: () =>
    @options.items.each(@addOne)

  addOne: (item) =>
    view = new Rudini.Views.Items.ItemView({model : item})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(items: @options.items.toJSON() ))
    @addAll()

    return this
