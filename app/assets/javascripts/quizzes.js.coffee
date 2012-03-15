$ ->
  $('#item-content').hide()
  $('#rating-panel').hide()
  $('.quiz').hide()
  $('.quiz').first().show()

  $('#quiz-back-btn').click(() ->
    return if $(this).hasClass('disabled')

    $('#quiz-show-btn').removeClass('disabled')
    $('#quiz-next-btn').removeClass('disabled')
    $('#item-content').hide()
    $('.quiz').hide()

    # get right quiz
    quiznum = parseInt($('#nth-quiz').text()) - 1

    $(this).addClass('disabled') if quiznum == 1
    
    $('.quiz:nth('+(quiznum-1)+')').show()
    $('#nth-quiz').text(quiznum)
  )

  $('#quiz-next-btn').click(() ->
    return if $(this).hasClass('disabled')

    $('#quiz-show-btn').removeClass('disabled')
    $('#quiz-back-btn').removeClass('disabled')
    $('#item-content').hide()
    $('.quiz').hide()

    # get right quiz
    quiznum = parseInt($('#nth-quiz').text()) + 1

    $(this).addClass('disabled') if quiznum == parseInt($('#tot-quiz').text())

    $('.quiz:nth('+(quiznum-1)+')').show()
    $('#nth-quiz').text(quiznum)
  )

  $('#quiz-show-btn').click(() ->
    return if $(this).hasClass('disabled')

    $('#item-content').show()
    $(this).addClass('disabled')

    # reveal rating panel when showing the last quiz answer
    $('#rating-panel').show() if parseInt($('#nth-quiz').text()) == parseInt($('#tot-quiz').text())
  )
    
