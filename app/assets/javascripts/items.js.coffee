# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

showNthQuiz = (n) ->
  # show the quiz, not the answer
  $('.quiz').hide()
  $('.quiz:nth('+n+')').show()
  $('#item-content').hide()
  $('.revealed').removeClass('revealed')

  # fix the text
  $('#nth-quiz').text(n+1)

  # render 
  MathJax.Hub.Queue(["Typeset",MathJax.Hub,"quiz-container"])

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

    # remove blanks on the correct quiz
    $('.blank').addClass('revealed')
  )

  $('.quiz-btn .btn').click(() ->
    $(this).parent().submit()
    return false
  )

  registerPlayBtns()

    
document.loadVideo = (videoid, start, end) ->
  if $(".video-container").hasClass("hidden") then $(".video-container").removeClass("hidden")
  $('#video').html('')
  clearInterval(document.end_vid)
  console.log(videoid + ", " + start + ", " + end);

  document.vid = Popcorn.youtube('#video', 'http://www.youtube.com/watch?v='+videoid)
  document.vid.play(start)
  document.end_vid = setInterval(() ->
    # console.log(document.vid.roundTime() + " " + end)
    if document.vid.roundTime() > end
      document.vid.pause()
      clearInterval(document.end_vid)
  , 1000)

document.showLectureItem = (id) ->
  RudiniApp.lectures.showItem(id)

# depricated...?
document.showItem = (id) ->
  $('.item-container > .item').hide()
  $('.quiz-container').hide()
  el = $('#item-' + id)
  el.show()
  title = "Item " + id + " - " + el.attr('data-title')
  document.title = title
  # History.pushState({item:id}, title, "?item=" + id)

  # fix quiz submit form
  $('#new_quiz').submit(() ->
                    $(this).unbind('submit').submit()
  )


document.showQuiz = () ->
  $('.item-container > .item').hide()
  $('.quiz-container').show()
  $.get('/spaceable_memories', (data) ->
    $('.quiz-container').html(data)
    initializeQuiz()
  )
  title = "LSRu - Quiz"
  document.title = title
  # History.pushState({ quiz: 1 }, title, "?quiz=1")

# clear search box on 'escape'
$(document).keyup((e) ->
  if e.keyCode == 27
    $("#search-box").val("")
    $('.nav-list > li').show()
  )

showFromURL = () ->
  return if window.location.pathname != '/'
  $('.item-container > .item').hide()
  $('.quiz-container').hide()
  current_item = $.getParameterByName('item')
  current_quiz = $.getParameterByName('quiz')
  if current_item && current_item.match(/\d+/)
    document.showItem(current_item)
  else if current_quiz
    document.showQuiz()
  else
    document.showItem('none')

registerPlayBtns = () ->
  $('.play-btn').click(() ->
    el = $(this)
    document.loadVideo(el.data('videoid'), el.data('start'), el.data('end'))
    return false
  )

$ ->
  showFromURL()

  # to make the browser 'back' functionality work...
  # loaded = false
  # window.onpopstate = (e) ->
  #   if (!loaded)
  #     loaded = true
  #     return
  #   else
  #     showFromURL()

  # registerPlayBtns()


  $('.nav-list a').click(() ->
    el = $(this)
    ary = el.attr('id').split("-")
    id = ary[ary.length - 1]
    document.showItem(id)
    return false

  )

  $('.study-initiate').click(() ->
    document.showQuiz()
    return false
  )

  $('.study-submit').click(() ->
    itemid = $(this).data('itemid')
    $('#item-study-info-'+itemid+' form').submit()
    return false
  )


