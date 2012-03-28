class Rudini.Models.Quiz extends Backbone.Model
  paramRoot: 'quiz'

  defaults:
    content: null
    item_id: null
    video_id: null
    video_time: null
    video_end: null

class Rudini.Collections.QuizzesCollection extends Backbone.Collection
  model: Rudini.Models.Quiz
  url: '/quizzes'
