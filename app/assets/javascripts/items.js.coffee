# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

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



$ ->
  $('.play-btn').click(() ->
    el = $(this)
    loadVideo(el.data('videoid'), el.data('start'), el.data('end'))
  )
