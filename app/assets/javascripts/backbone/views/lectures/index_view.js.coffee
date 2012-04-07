Rudini.Views.Lectures ||= {}

class Rudini.Views.Lectures.IndexView extends Backbone.View
  template: JST["backbone/templates/lectures/index"]

  initialize: () ->
    @options.lectures.bind('reset', @addAll)

  addAll: () =>
    @options.lectures.each(@addOne)

  addOne: (lecture) =>
    view = new Rudini.Views.Lectures.LectureView({model : lecture})
    @$("#lectures-list").append(view.render().el)

  render: =>
    $(@el).html(@template(lectures: @options.lectures.toJSON() ))
    @addAll()

    return this
