class Rudini.Routers.ItemsRouter extends Backbone.Router
  initialize: (options) ->
    @items = new Rudini.Collections.ItemsCollection()
    @items.reset options.items

  routes:
    "/index"    : "index"
    "/:id"      : "show"
    ".*"        : "index"

  index: ->
    @view = new Rudini.Views.Items.IndexView(items: @items)
    $("#items").html(@view.render().el)

  show: (id) ->
    item = @items.get(id)

    @view = new Rudini.Views.Items.ShowView(model: item)
    $("#items").html(@view.render().el)

