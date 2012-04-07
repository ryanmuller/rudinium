class Rudini.Models.Lecture extends Backbone.Model
  paramRoot: 'lecture'

  defaults:
    title: null
    video_id: null
    number: null

  hasItem: (id) ->

    item = _.find(@attributes.items, (item) ->
      return item == id)
    return !(item == undefined)
    
class Rudini.Collections.LecturesCollection extends Backbone.Collection
  model: Rudini.Models.Lecture
  url: '/lectures'
