# window.items
class Rudini.Routers.ItemsRouter extends Backbone.Router
  initialize: (options) ->
    console.log('initializing items')
    @items = new Rudini.Collections.ItemsCollection()
    @items.reset options.items
    
    console.log('initializing memories')

    $.getJSON("/spaceable_memories", (data) ->
      # RudiniApp.studying.reset data
    )
    console.log(RudiniApp.studying)
 

  routes:
    ""	        	: "index"
    "/items/:id"      	: "show"
    "/items"        	: "index"
    "/items/.*"        	: "index"


  renderPage: () ->
    @view = new Rudini.Views.Page.PageView(items: @items)
    $("#backbone-page").html(@view.render().el)

  renderSidebar: () ->
    @view = new Rudini.Views.Page.SidebarView(items: @items)
    $("#navigation-sidebar").html(@view.render().el)


  index: ->
    this.renderPage()
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

    # If sidebar is absent, must be navigating in from another page
    # thus, render page structure + sidebar
    # if not, just render item show 
    if $("#item-nav-list").length == 0
      this.renderPage()
      this.renderSidebar()
    
    
    @view = new Rudini.Views.Items.ShowView({model: item, memory: memory})
    $("#quiz-container").hide()
    $("#item-container").show()
    $("#item-container").html(@view.render().el)

    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-container"])
