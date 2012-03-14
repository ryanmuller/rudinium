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

showItem = (id) -> 
  $(".item-container > .item").hide()
  el = $('#item-' + id)
  el.show()
  title = "Item " + id + " - " + el.attr('data-title')
  console.log(title)
  document.title = title
  History.pushState({item:id}, title, "?item=" + id)

showFromURL = () ->
  current_item = $.getParameterByName('item')
  if current_item && current_item.match(/\d+/)
    showItem(current_item)
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

  $('#search').change(() ->

    val = $('#search').val()
    console.log(val)
    if val != ""
      $('li').hide()
      $('li:icontains("'+val+'")').show()
    else
      $('li').show()
    
  )

  $('.play-btn').click(() ->
    el = $(this)
    loadVideo(el.data('videoid'), el.data('start'), el.data('end'))
    return false
  )

  $('#search-box').keyup(() ->

    val = $('#search-box').val()
    console.log(val)
    if val != ""
      $('.nav-list > li').hide()
      $('.nav-list > li:icontains("' + val + '")').show()
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

  $('.study-submit').click(() ->
    itemid = $(this).data('itemid')
    $('#item-study-info-'+itemid+' form').submit()
  )

