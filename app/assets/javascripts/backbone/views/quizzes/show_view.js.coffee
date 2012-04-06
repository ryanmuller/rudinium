Rudini.Views.Quizzes ||= {}

class Rudini.Views.Quizzes.ShowView extends Backbone.View
  template: JST["backbone/templates/quizzes/show"]

  events:
    "click .play-btn" : "play"

  play: (e) ->
    quiz = $(e.currentTarget).data() # gets the video_id/start/end from play button
    document.loadVideo(quiz.videoid, quiz.start, quiz.end)
    return false


  # renders the quiz. It is passed the 'memory' model from the StudyRouter
  # First, pulls the associated quiz models from the "quizzes" array.
  # Then, renders the template.
  render: ->
    quizzes = @model.quizzes('json')
    number = quizzes.length
    item = @model.item().toJSON()
    switch number
      when 0 then number_text = null
      when 1 then number_text = "1 quiz"
      else number_text = number + " quizzes"

    $(@el).html(@template({quizzes: quizzes, item: item, info: {number: number, number_text: number_text}, memory: @model.toJSON()}))

    return this

