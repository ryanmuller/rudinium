class Rudini.Views.Items.KoanView extends Backbone.View
  template: JST["backbone/templates/items/koan"]

  events:
    keypress: 'key'

  key: (e) ->
    if e.keyCode == 13
      if $(@el).find('input').val() == @model.get('answer')
        alert('correct!')

  render: ->
    $el = $(@el)

    options = @model.toJSON()
    $el.html(@template(options))

    # convert .blank field to a text input, saving answer
    $blank = $el.find('.blank')

    @model.set('answer', $blank.text())

    $in = $('<input>').attr('type','text')
    $blank.replaceWith($in)

    return this
