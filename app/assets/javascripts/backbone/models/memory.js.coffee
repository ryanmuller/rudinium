# this class holds the memories due for the student.
# contains an array of quizzes and the item_id

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

class Rudini.Collections.MemoriesCollection extends Backbone.Collection
  model: Rudini.Models.Memory
  url: '/spaceable_memories'


  # Pops first memory, returns object with memory, quiz array, and item_id
  popQuiz: () ->
    memory = this.models.pop()
    return new Object({ memory: memory, quizzes: memory.attributes.quizzes, item: memory.attributes.item_id })

