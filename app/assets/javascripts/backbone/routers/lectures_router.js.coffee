class Rudini.Routers.LecturesRouter extends Backbone.Router
  initialize: (options) ->
    @lectures = new Rudini.Collections.LecturesCollection()
    @lectures.reset options.lectures
    console.log('initializing lectures')

  routes:
    "/lectures/:id"    	: "show"
    "/lectures"        	: "index"
    "/lectures/.*"     	: "index"


  showItem: (item) ->
    @view = new Rudini.Views.Items.ShowView(model: item)
    $("#item-container").html(@view.render().el)
    MathJax.Hub.Queue(["Typeset",MathJax.Hub,"item-container"])

  index: ->
    @view = new Rudini.Views.Lectures.IndexView(lectures: @lectures)
    $("#backbone-page").html(@view.render().el)

  show: (id) ->
    lecture = @lectures.get(id)

    @view = new Rudini.Views.Lectures.ShowView(model: lecture)
    $("#backbone-page").html(@view.render().el)
    document.loadVideo(lecture.attributes.video_id, 0, 9999)
    _.each(lecture.attributes.items, (id) ->
      item = window.items.items.get(id).attributes
      document.vid.code({ start: item.video_time, end: item.video_end, onStart: () ->
        document.showLectureItem(item.id)}))








