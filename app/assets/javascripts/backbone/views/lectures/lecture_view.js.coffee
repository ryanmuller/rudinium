Rudini.Views.Lectures ||= {}

class Rudini.Views.Lectures.LectureView extends Backbone.View
  template: JST["backbone/templates/lectures/lecture"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
