# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

loadVideo = (videoid, start) ->
  $('#video').html('')
  vid = Popcorn.youtube('#video', 'http://www.youtube.com/watch?v='+videoid)
  vid.play(start)


$ ->
  $('.play-btn').click(() ->
    loadVideo($(this).data('videoid'), $(this).data('start'))
  )
