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

document.showItem = (id) ->
  $('.item-container > .item').hide()
  $('.quiz-container').hide()
  el = $('#item-' + id)
  el.show()
  title = "Item " + id + " - " + el.attr('data-title')
  document.title = title
  History.pushState({item:id}, title, "?item=" + id)

  # fix quiz submit form
  $('#new_quiz').submit(() ->
                    $(this).unbind('submit').submit()
  )

showNavItem = (id) ->
  $('#nav-item-' + id).show()


document.showQuiz = () ->
  $('.item-container > .item').hide()
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
  loaded = false
  window.onpopstate = (e) ->
    if (!loaded)
      loaded = true
      return
    else
      showFromURL()

  registerPlayBtns()

  $('#search-box').keyup(() ->
    val = $('#search-box').val()

    # show all and return if search box is empty
    if val == ""
      $('.nav-list > li').show()
      return false

    # match patterns for special labels
    pattern = ///^(rudin|chapter|lecture|section):(.*)///
    [full, label, search] = val.match(pattern) || [null, null, null]

    # show results either based on label or based on full-text search of the item
    if search
      $('.nav-list > li').hide()
      switch (label)
        when "rudin" then showNavItem $(item).attr('data-id') for item in $("div[data-rudineq='" + search + "']")
        when "chapter" then showNavItem $(item).attr('data-id') for item in $("div[data-rudinch='" + search + "']")
        when "lecture" 
          r = new RegExp(search, 'i')
          showNavItem $(item).attr('data-id') for item in $("div[data-lectureid='" + search + "']")
          showNavItem $(item).attr('data-id') for item in $("div[data-lecturename]").filter(() -> 
            return $(this).attr('data-lecturename').match(r) 
          )
        when "section"
          r = new RegExp(search, 'i')
          showNavItem $(item).attr('data-id') for item in $("div[data-rudinsec]").filter(() -> 
            return $(this).attr('data-rudinsec').match(r) 
          )
    else
      $('.nav-list > li').hide()
      showNavItem $(item).attr('data-id') for item in $('.item:icontains("' + val + '")')
  )

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


