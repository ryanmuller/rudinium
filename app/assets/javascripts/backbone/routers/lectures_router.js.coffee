class Rudini.Routers.LecturesRouter extends Backbone.Router
  initialize: (options) ->
    @lectures = new Rudini.Collections.LecturesCollection()
    @lectures.reset options.lectures

  routes:
    "/new"      : "newLecture"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newLecture: ->
    @view = new Rudini.Views.Lectures.NewView(collection: @lectures)
    $("#lectures").html(@view.render().el)

  index: ->
    @view = new Rudini.Views.Lectures.IndexView(lectures: @lectures)
    $("#lectures").html(@view.render().el)

  show: (id) ->
    lecture = @lectures.get(id)

    @view = new Rudini.Views.Lectures.ShowView(model: lecture)
    $("#lectures").html(@view.render().el)

  edit: (id) ->
    lecture = @lectures.get(id)

    @view = new Rudini.Views.Lectures.EditView(model: lecture)
    $("#lectures").html(@view.render().el)
