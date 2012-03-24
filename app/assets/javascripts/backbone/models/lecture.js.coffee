class Rudini.Models.Lecture extends Backbone.Model
  paramRoot: 'lecture'

  defaults:
    title: null
    video_id: null
    number: null

class Rudini.Collections.LecturesCollection extends Backbone.Collection
  model: Rudini.Models.Lecture
  url: '/lectures'
