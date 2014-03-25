class Rudini.Views.Items.KoanView extends Backbone.View
  template: JST["backbone/templates/items/koan"]

  events:
    keypress: 'key'

  $in: ->
    $(@el).find('input')

  initialize: ->
    docCookies.setItem("currentKoan", @model.id)

  nextKoan: ->
    quizzes = @model.collection
    currentIndex = quizzes.indexOf(@model)
    nextKoan = quizzes.at(currentIndex + 1)
    RudiniApp.study.navigate("koans/#{nextKoan.id}", {trigger: true})

  normalize: (text) ->
    text = text.toLowerCase()
    text = text.replace(/\s/g, "") # remove all whitespace

  checkAnswer: (correct, submitted) ->
    @normalize(correct) == @normalize(submitted)

  key: (e) ->
    if e.keyCode == 13
      if @checkAnswer(@$in().val(), @model.get('answer'))
        @nextKoan()
      else # wrong!
        $koanArea = $(@el).find('.quiz .well')
        $koanArea.css('background-color', '#fcc')
        $koanArea.fadeOut(0)
        $koanArea.fadeIn(300)

  focus: ->
    @$in().focus()

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
