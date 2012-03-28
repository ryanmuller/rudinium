Rudini.Views.Items ||= {}

class Rudini.Views.Items.IndexView extends Backbone.View
  template: JST["backbone/templates/items/index"]

  events:
    "keyup #search-box" : "search"


  showNavItem: (id) ->
    $('#nav-item-' + id).show()

  search: () ->
    val = $("#search-box").val()

    pattern = ///^(rudin|chapter|lecture|section):(.*)///
    [full, label, search] = val.match(pattern) || [null, null, null]
    search ||= val 

    console.log(this.options.items.search(search, label))
  






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
