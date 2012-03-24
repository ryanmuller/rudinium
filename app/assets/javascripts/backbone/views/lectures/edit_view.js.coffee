Rudini.Views.Lectures ||= {}

class Rudini.Views.Lectures.EditView extends Backbone.View
  template : JST["backbone/templates/lectures/edit"]

  events :
    "submit #edit-lecture" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (lecture) =>
        @model = lecture
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
