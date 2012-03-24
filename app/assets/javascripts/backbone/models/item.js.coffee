class Rudini.Models.Item extends Backbone.Model
  paramRoot: 'item'

  defaults:
    name: null
    content: null
    label: null
    video_id: null
    video_time: null
    video_end: null
    item_info: null
    lecture_id: null

class Rudini.Collections.ItemsCollection extends Backbone.Collection
  model: Rudini.Models.Item
  url: '/items'
