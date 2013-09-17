#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require alerts
#
Froogaloop( $('#intro-video-player')[0] ).addEvent('ready', ->
  f = $f($('#intro-video-player')[0])
  f.addEvent('play', ->
    console.log("playing")
    return true
  )
  window.vimeoPlayer = f
)

$("#play").on("click", ->
  $("#intro-text").hide()
  $('#intro-video-player').show()
  window.vimeoPlayer.api("play")
)
