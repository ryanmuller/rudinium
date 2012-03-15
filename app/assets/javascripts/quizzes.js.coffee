
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

$ ->
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
    
