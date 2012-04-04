Rudini.Views.Quizzes ||= {}

class Rudini.Views.Quizzes.RatingView extends Backbone.View
  template: JST["backbone/templates/quizzes/rating"]

  events:
    "click .submit" : "submit"

  submit: (e) ->
    console.log('submitting...')
    $(e.target).parent().submit()
    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
