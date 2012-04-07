Rudini.Views.Memories ||= {}

class Rudini.Views.Memories.RatingView extends Backbone.View
  template: JST["backbone/templates/memories/rating"]

  events:
    "click .submit" : "rate"

  rate: (e) ->
    data = {_method: "put", spaceable_memory: { quality: $(e.target).attr('data-quality')}}
    memory = @model
    $.post("/spaceable_memories/" + @model.id , data, (r) ->
      console.log('fetching...')
      memory.set(r)
      RudiniApp.study.loadNextMemory()
      )
    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

