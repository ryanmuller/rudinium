Rudini.Views.Quizzes ||= {}


class Rudini.Views.Quizzes.ShowView extends Backbone.View
  template: JST["backbone/templates/quizzes/show"]

  events:
    "click .play-btn" : "play"

  play: ->
    quiz = @model.attributes
    document.loadVideo(quiz.video_id, quiz.video_time, quiz.video_end)
    return false


  render: ->
    quizzes = @model.attributes.quizzes.map((id) ->
      return RudiniApp.study.quizzes.get(id).toJSON())
    number = quizzes.length
    item = @model.item().toJSON()
    switch number
      when 0 then number_text = null
      when 1 then number_text = "1 quiz"
      else number_text = number + " quizzes"

    $(@el).html(@template({quizzes: quizzes, item: item, info: {number: number, number_text: number_text}, memory: @model.toJSON()}))
    return this

