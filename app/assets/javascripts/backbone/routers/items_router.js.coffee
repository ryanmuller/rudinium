class Rudini.Routers.ItemsRouter extends Backbone.Router
  initialize: (options) ->
    @items = new Rudini.Collections.ItemsCollection()
    @items.reset options.items
    
    # renders sidebar on items collection...
    @view = new Rudini.Views.Items.IndexView(items: @items)
    $("#navigation-sidebar").html(@view.render().el)

  routes:
    "/index"    : "index"
    "/:id"      : "show"
    ".*"        : "index"

  index: ->
    # renders sidebar in the initialize function above.
    # add more code here as needed.

  show: (id) ->
    item = @items.get(id)
    
    @view = new Rudini.Views.Items.ShowView(model: item)
    $("#item-container").html(@view.render().el)

