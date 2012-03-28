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
    this.renderPage()
    this.renderSidebar()
   
    none_item = '<div class="item" id="item-none">' +
      '<p>Search for an item on the left!</p>' + 
      '</div>'
    $("#item-container").html(none_item)
    

  show: (id) ->
    item = @items.get(id)

    title = "Item " + item.id + " - " + item.attributes.name 
    document.title = title

    # If sidebar is absent, must be navigating in from another page
    # thus, render page structure + sidebar
    # if not, just render item show 
    if $("#item-nav-list").length == 0
      this.renderPage()
      this.renderSidebar()
    
    @view = new Rudini.Views.Items.ShowView(model: item)
    $("#item-container").html(@view.render().el)

    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-container"])


  showForLecture: (id) ->
    console.log("showing for lecture...")
    item = window.items.items.get(id)
    @view = new Rudini.Views.Items.ShowView(model: item)
    $("#item-container").html(@view.render().el)
    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-container"])
    
  # renders the items page structure
  renderPage: () ->
    @view = new Rudini.Views.Items.PageView(items: @items)
    $("#backbone-page").html(@view.render().el)

  # renders the items sidebar
  renderSidebar: () ->
    @view = new Rudini.Views.Items.SidebarView(items: @items)
    $("#navigation-sidebar").html(@view.render().el)
