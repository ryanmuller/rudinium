# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


document.loadVideo = (videoid, start, end) ->
  if $(".video-container").hasClass("hidden") then $(".video-container").removeClass("hidden")

  player.loadVideoById
    videoId: videoid
    startSeconds: start
    endSeconds: end

# clear search box on 'escape', give focus to search box
$(document).keyup((e) ->
  if e.keyCode == 27
    $("#search-box").val("")
    $("#search-box").focus()
    $('.nav-list > li').show()
  )

$(document).ready(() ->
  $(window).resize(() ->
    window_height = $(window).height()
    sidebar_height = window_height - 150
    $("#item-nav-list").height(sidebar_height))

  )


