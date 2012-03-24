class Rudini.Routers.ItemsRouter extends Backbone.Router
  initialize: (options) ->
    @items = new Rudini.Collections.ItemsCollection()
    @items.reset options.items

  routes:
    "/new"      : "newItem"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newItem: ->
    @view = new Rudini.Views.Items.NewView(collection: @items)
    $("#items").html(@view.render().el)

  index: ->
    @view = new Rudini.Views.Items.IndexView(items: @items)
    $("#items").html(@view.render().el)

  show: (id) ->
    item = @items.get(id)

    @view = new Rudini.Views.Items.ShowView(model: item)
    $("#items").html(@view.render().el)

  edit: (id) ->
    item = @items.get(id)

    @view = new Rudini.Views.Items.EditView(model: item)
    $("#items").html(@view.render().el)
