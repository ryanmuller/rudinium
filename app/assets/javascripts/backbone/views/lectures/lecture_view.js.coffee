Rudini.Views.Lectures ||= {}

class Rudini.Views.Lectures.LectureView extends Backbone.View
  template: JST["backbone/templates/lectures/lecture"]


  tagName: "li"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
