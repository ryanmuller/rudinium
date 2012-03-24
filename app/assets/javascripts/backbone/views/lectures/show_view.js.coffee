Rudini.Views.Lectures ||= {}

class Rudini.Views.Lectures.ShowView extends Backbone.View
  template: JST["backbone/templates/lectures/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
