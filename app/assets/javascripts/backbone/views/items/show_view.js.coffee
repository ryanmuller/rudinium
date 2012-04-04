Rudini.Views.Items ||= {}

class Rudini.Views.Items.ShowView extends Backbone.View
  template: JST["backbone/templates/items/show"]

  events:
    "click .play-btn" : "play"
    "click .study-btn" : "study"


  play: ->
    item = @model.attributes
    document.loadVideo(item.video_id, item.video_time, item.video_end)
    return false

  study: ->
    item_id = @model.id
    data = {spaceable_memory: {component_id: item_id}}
    $.post("/spaceable_memories", data)
    return false
    

  render: ->
    options = @model.toJSON()
    options['study_info'] = { studying: @model.studying(), memory: @model.memory(), due: @model.due() }
    console.log('rendering')
    console.log(options)
    $(@el).html(@template(options))
    return this
