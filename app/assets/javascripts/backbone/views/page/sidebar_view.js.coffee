Rudini.Views.Page ||= {}

class Rudini.Views.Page.SidebarView extends Backbone.View
  template: JST["backbone/templates/page/sidebar"]

  className: "row"

  events:
    "keyup #search-box" : "search"

  search: () ->
    val = $("#search-box").val()
    if val == ""
      $('.nav-list > li').show()

    pattern = ///^(rudin|chapter|lecture|section):(.*)///
    [full, label, search] = val.match(pattern) || [null, null, null]

    # if no label found, set search back to value of search-box
    search ||= val 

    # call search function on Items collection; 
    # returns wrapper of matched items
    match = this.options.items.search(search, label)._wrapped

    # show matching items in sidebar
    $('.nav-list > li').hide()
    _.each(match, (e) ->
      $('#nav-item-' + e.id).show())
      

  initialize: () ->
    @options.items.bind('reset', @addAll)

  addAll: () =>
    @options.items.each(@addOne)

  addOne: (item) =>
    view = new Rudini.Views.Items.ItemView({model : item})
    @$("#item-nav-list").append(view.render().el)

  render: =>
    $(@el).html(@template(items: @options.items.toJSON() ))
    @addAll()
    
    return this
