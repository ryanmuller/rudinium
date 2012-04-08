Rudini.Views.Memories ||= {}

class Rudini.Views.Memories.RatingView extends Backbone.View
  template: JST["backbone/templates/memories/rating"]

  events:
    "click .submit" : "rate"

  rate: (e) ->
    data = {_method: "put", spaceable_memory: { quality: $(e.target).attr('data-quality')}}
    memory = @model
    $.post("/spaceable_memories/" + @model.id , data, (r) ->
      memory.set(r)
      RudiniApp.study.loadNextMemory()
      $("#study-nav-due").text(RudiniApp.study.memories.due())
      )
    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

