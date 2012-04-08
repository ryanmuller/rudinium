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
    RudiniApp.study.memories.create({item_id: item_id}, {success: () ->
      $("#study-nav-due").text(RudiniApp.study.memories.due()) })
    
    $(".item-study-info").html("<button class='btn btn-small btn-danger disabled'>Due</button>")
    return false
    

  render: ->
    options = @model.toJSON()
    options['study_info'] = { studying: @model.studying(), memory: @model.memory(), due: @model.due() }
    $(@el).html(@template(options))
    return this
