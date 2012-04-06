class Rudini.Models.Memory extends Backbone.Model
  paramRoot: 'memory'

  defaults:
    quizzes: null
    item_id: null
    due: null

  # finds associated item with the memory...
  item: ->
    id = this.attributes.item_id
    RudiniApp.items.items.find((model) ->
      return model.get("id") == id) 

  # returns associated quiz objects
  # can optionally specify that you want the quizzes
  # returned as their json objects. Otherwise, returns them
  # as Quiz objects.
  quizzes: (format = 'model') -> 
    if format == 'json'
      this.attributes.quizzes.map((id) ->
        return RudiniApp.study.quizzes.get(id).toJSON())
    else
      this.attributes.quizzes.map((id) ->
        return RudiniApp.study.quizzes.get(id))


class Rudini.Collections.MemoriesCollection extends Backbone.Collection
  model: Rudini.Models.Memory
  url: '/spaceable_memories'

