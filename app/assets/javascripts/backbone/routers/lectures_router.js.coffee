class Rudini.Routers.LecturesRouter extends Backbone.Router
  initialize: (options) ->
    @lectures = new Rudini.Collections.LecturesCollection()
    @lectures.reset options.lectures

  routes:
    "/lectures/:id"    			: "show"
    "/lectures/:id/items/:item_id"	: "showWithItem"
    "/lectures"        			: "index"
    "/lectures/.*"     			: "index"


  showItem: (id) ->
    item = RudiniApp.items.items.get(id)
    @view = new Rudini.Views.Items.ShowView(model: item)
    $("#item-container").html(@view.render().el)
    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-container"])

  show: (id) ->
    lecture = @lectures.get(id)
    @view = new Rudini.Views.Lectures.ShowView(model: lecture)
    $("#backbone-page").html(@view.render().el)

    document.loadVideo(lecture.attributes.video_id, 0, 9999)
    _.each(lecture.attributes.items, (id) ->
      item = RudiniApp.items.items.get(id).attributes
      document.vid.code({ start: item.video_time, end: item.video_end, onStart: () ->
        document.showLectureItem(item.id)}))
 
  showWithItem: (id, item_id) ->
    lecture = @lectures.get(id)
    @view = new Rudini.Views.Lectures.ShowView(model: lecture)
    $("#backbone-page").html(@view.render().el)

    item = RudiniApp.items.items.get(item_id).attributes
    this.showItem(item.id)

    document.loadVideo(lecture.attributes.video_id, item.video_time, item.video_end)
    _.each(lecture.attributes.items, (id) ->
      i = RudiniApp.items.items.get(id).attributes
      document.vid.code({ start: i.video_time, end: i.video_end, onStart: () ->
        document.showLectureItem(i.id)}))

  index: ->
    @view = new Rudini.Views.Lectures.IndexView(lectures: @lectures)
    $("#backbone-page").html(@view.render().el)


