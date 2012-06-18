class Rudini.Routers.LecturesRouter extends Backbone.Router

  # Initializes Lectures router, with the lectures collection.
  # Actual object is assigned to RudiniApp.lectures 
  initialize: (options) ->
    @lectures = new Rudini.Collections.LecturesCollection()
    @lectures.reset options.lectures

  routes:
    "/lectures/:id"    			: "show"
    "/lectures/:id/items/:item_id"	: "showWithItem"
    "/lectures"        			: "index"
    "/lectures/.*"     			: "index"


  # input: id (item_id)
  # displays the item alongside lecture video
  showItem: (id) ->
    console.log('showing lecture item...')
    item = RudiniApp.items.items.get(id)
    @view = new Rudini.Views.Items.ShowView(model: item)
    $("#item-container").html(@view.render().el)
    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-container"])

  # show function for lecture.
  # input: id (lecture_id)
  # loads lecture template, initializes associated items to display
  # at appropriate time.
  show: (id) ->
    document.title = "LSRu - Lecture " + id
    lecture = @lectures.get(id)
    @view = new Rudini.Views.Lectures.ShowView(model: lecture)
    $("#backbone-page").html(@view.render().el)

    document.loadVideo(lecture.attributes.video_id, 0, 9999)
    _.each(lecture.attributes.items, (id) ->
      item = RudiniApp.items.items.get(id).attributes
      document.vid.code({ start: item.video_time, end: item.video_end, onStart: () ->
        RudiniApp.lectures.showItem(item.id)}))
 
  # Lecture "show" at specific item.
  # same as show(id) above, but initializes video at the beginning of 
  # item (given by item_id)
  # still need to verify if item/lecture combo is valid, and do something else
  # if it's not.
  showWithItem: (id, item_id) ->
    lecture = @lectures.get(id)
    document.title = "LSRu - Lecture " + id
    @view = new Rudini.Views.Lectures.ShowView(model: lecture)
    $("#backbone-page").html(@view.render().el)

    item = RudiniApp.items.items.get(item_id).attributes
    this.showItem(item.id)

    document.loadVideo(lecture.attributes.video_id, item.video_time, item.video_end)
    _.each(lecture.attributes.items, (id) ->
      i = RudiniApp.items.items.get(id).attributes
      document.vid.code({ start: i.video_time, end: i.video_end, onStart: () ->
        RudiniApp.lectures.showItem(i.id)}))

  # lecture index. Displays a list of lectures for user to select.
  index: ->
    document.title = "LSRu - Lectures"
    @view = new Rudini.Views.Lectures.IndexView(lectures: @lectures)
    $("#backbone-page").html(@view.render().el)


