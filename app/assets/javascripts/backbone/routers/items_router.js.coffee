class Rudini.Routers.ItemsRouter extends Backbone.Router
  
  # Initializes Items router, with a collection of all items.
  # Actual object assigned to RudiniApp.items
  # (and so the "items" collection is available at
  #   "RudiniApp.items.items")
  initialize: (options) ->
    @items = new Rudini.Collections.ItemsCollection()
    @items.reset options.items

  routes:
    ""	        	: "index"
    "/items/:id"      	: "show"
    "/items"        	: "index"
    "/items/.*"        	: "index"


  renderSidebar: () ->
    @view = new Rudini.Views.Page.SidebarView(items: @items)
    $("#backbone-page").html(@view.render().el)

  index: ->
    this.renderSidebar()
   
    none_item = '<div class="item" id="item-none">' +
      '<p>Search for an item on the left!</p>' + 
      '</div>'

    $("#item-container").html(none_item)
    

  show: (id) ->
    item = @items.get(id)
    memory = item.memory()

    title = "Item " + item.id + " - " + item.attributes.name 
    document.title = title

    # If sidebar is absent, must be navigating in from another layout
    # thus, render page structure/sidebar
    # if not, just render item show 
    if $("#item-nav-list").length == 0
      this.renderSidebar()
    
    
    @view = new Rudini.Views.Items.ShowView({model: item, memory: memory})
    $("#study-container").hide()
    $("#item-container").show()
    $("#item-container").html(@view.render().el)

    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-container"])
