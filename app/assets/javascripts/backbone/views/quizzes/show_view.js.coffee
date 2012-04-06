Rudini.Views.Quizzes ||= {}


class Rudini.Views.Quizzes.ShowView extends Backbone.View
  template: JST["backbone/templates/quizzes/show"]

  events:
    "click .play-btn" : "play"

  play: (e) ->
    console.log('playing!')
    quiz = $(e.currentTarget).data() # gets the video_id/start/end from play button
    console.log(quiz)
    document.loadVideo(quiz.videoid, quiz.start, quiz.end)
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

