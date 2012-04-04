Rudini.Views.Quizzes ||= {}

class Rudini.Views.Quizzes.ShowView extends Backbone.View
  template: JST["backbone/templates/quizzes/show"]

  events:
    "click .play-btn" : "play"
    "click .next" : "next"
    "click .btn-submit" : "submit"

  play: ->
    quiz = @model.attributes
    document.loadVideo(quiz.video_id, quiz.video_time, quiz.video_end)
    return false

  next: ->
    console.log("clicking...")
    memoryObject = window.studying.popQuiz()
    quizzes.runMemory(memoryObject.memory)
    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

