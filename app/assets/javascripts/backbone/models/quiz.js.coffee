class Rudini.Models.Quiz extends Backbone.Model
  paramRoot: 'quiz'

  defaults:
    content: null
    item_id: null
    video_id: null
    video_time: null
    video_end: null

  # returns memory associated with this quiz.
  # assumes that each quiz is only attached to a
  # single memory for any given user...
  memory: () ->
    return undefined if ! (RudiniApp.study && RudiniApp.study.memories)
    quiz_id = @attributes.id
    RudiniApp.study.memories.find((model) ->
      return _.include(model.get("quizzes"), quiz_id ))

class Rudini.Collections.QuizzesCollection extends Backbone.Collection
  model: Rudini.Models.Quiz
  url: '/quizzes'


