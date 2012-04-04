Rudini.Views.Items ||= {}

class Rudini.Views.Items.ShowView extends Backbone.View
  template: JST["backbone/templates/items/show"]

  events:
    "click .play-btn" : "play"


  play: ->
    item = @model.attributes
    document.loadVideo(item.video_id, item.video_time, item.video_end)
    return false

  render: ->
    options = @model.toJSON()
    options['memory'] = @model.memory()
    console.log('rendering')
    console.log(options)
    $(@el).html(@template(@model.toJSON() ))
    return this
