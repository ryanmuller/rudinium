# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

    
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


# clear search box on 'escape', give focus to search box
$(document).keyup((e) ->
  if e.keyCode == 27
    $("#search-box").val("")
    $("#search-box").focus()
    $('.nav-list > li').show()
  )


