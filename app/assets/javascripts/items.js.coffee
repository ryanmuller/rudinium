# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


showNthQuiz = (n) ->
  # show the quiz, not the answer
  $('.quiz').hide()
  $('.quiz:nth('+n+')').show()
  $('#item-content').hide()

  # fix the text
  $('#nth-quiz').text(n+1)

  # fix the buttons
  $('#quiz-show-btn').removeClass('disabled')
  if n == 0
    $('#quiz-back-btn').addClass('disabled')
  else
    $('#quiz-back-btn').removeClass('disabled')

  if n == parseInt($('#tot-quiz').text())-1
    $('#quiz-next-btn').addClass('disabled')
  else
    $('#quiz-next-btn').removeClass('disabled')
    

initializeQuiz = () ->
  showNthQuiz(0)

  $('#quiz-back-btn').click(() ->
    return if $(this).hasClass('disabled')
    showNthQuiz(parseInt($('#nth-quiz').text())-2)
  )

  $('#quiz-next-btn').click(() ->
    return if $(this).hasClass('disabled')
    showNthQuiz(parseInt($('#nth-quiz').text()))
  )

  $('#quiz-show-btn').click(() ->
    return if $(this).hasClass('disabled')

    $('#item-content').show()
    $(this).addClass('disabled')
  )

    
loadVideo = (videoid, start, end) ->
  $('#video').html('')
  clearInterval(document.end_vid)

  document.vid = Popcorn.youtube('#video', 'http://www.youtube.com/watch?v='+videoid)
  document.vid.play(start)
  document.end_vid = setInterval(() ->
    console.log(document.vid.roundTime() + " " + end)
    if document.vid.roundTime() > end
      document.vid.pause()
      clearInterval(document.end_vid)
  , 1000)

showItem = (id) ->
  el = $('#item-' + id)
  el.show()
  title = "Item " + id + " - " + el.attr('data-title')
  console.log(title)
  document.title = title
  History.pushState({item:id}, title, "?item=" + id)

showNavItem = (id) ->
  $('#nav-item-' + id).show()


showQuiz = () ->
  $('.quiz-container').show()
  $.get('/spaceable_memories', (data) ->
    $('.quiz-container').html(data)
    initializeQuiz()
  )
  title = "LSRu - Quiz"
  document.title = title
  History.pushState({ quiz: 1 }, title, "?quiz=1")


showFromURL = () ->
  return if window.location.pathname != '/'
  $('.item-container > .item').hide()
  $('.quiz-container').hide()
  current_item = $.getParameterByName('item')
  current_quiz = $.getParameterByName('quiz')
  if current_item && current_item.match(/\d+/)
    showItem(current_item)
  else if current_quiz
    showQuiz()
  else
    showItem('none')


$ ->
  showFromURL()

  # to make the browser 'back' functionality work...
  loaded = false
  window.onpopstate = (e) ->
    if (!loaded)
      loaded = true
      return
    else
      showFromURL() 

  $('.play-btn').click(() ->
    el = $(this)
    loadVideo(el.data('videoid'), el.data('start'), el.data('end'))
    return false
  )

  $('#search-box').keyup(() ->
    val = $('#search-box').val()
    if val != ""
      $('.nav-list > li').hide()
      showNavItem $(item).attr('data-id') for item in $('.item:icontains("' + val + '")')
    else
      $('.nav-list > li').show()

  )

  $('.nav-list a').click(() ->
    el = $(this)
    ary = el.attr('id').split("-")
    id = ary[ary.length - 1]
    console.log(id)
    showItem(id)
    return false

  )

  $('#study-initiate').click(() ->
    showQuiz()
    return false
  )

  $('.study-submit').click(() ->
    itemid = $(this).data('itemid')
    $('#item-study-info-'+itemid+' form').submit()
    return false
  )

