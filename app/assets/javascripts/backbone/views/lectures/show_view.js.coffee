Rudini.Views.Lectures ||= {}

class Rudini.Views.Lectures.ShowView extends Backbone.View
  template: JST["backbone/templates/lectures/show"]

  className: "row"

  events:
    "click .play-btn" : "play"

  play: ->
    lecture = @model.attributes
    document.loadVideo(lecture.video_id, 0, 9999)
    return false


  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
