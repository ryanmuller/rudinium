class Rudini.Routers.ItemsRouter extends Backbone.Router
  initialize: (options) ->
    @items = new Rudini.Collections.ItemsCollection()
    @items.reset options.items
    console.log('initializing items')

  routes:
    ""	        	: "index"
    "/items/:id"      	: "show"
    "/items"        	: "index"
    "/items/.*"        	: "index"

  index: ->
    if $("#navigation-sidebar").length == 0
      @view = new Rudini.Views.Items.IndexView(items: @items)
      $("#backbone-page").html(@view.render().el)
    
    none_item = '<div class="item" id="item-none">' +
      '<p>Search for an item on the left!</p>' + 
      '</div>'
    $("#item-container").html(none_item)
    

  show: (id) ->
    this.index()
    item = @items.get(id)
    
    @view = new Rudini.Views.Items.ShowView(model: item)
    $("#item-container").html(@view.render().el)
    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-container"])


  showForLecture: (id) ->
    console.log("showing for lecture...")
    item = window.items.items.get(id)
    @view = new Rudini.Views.Items.ShowView(model: item)
    $("#item-container").html(@view.render().el)
    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-container"])
    
