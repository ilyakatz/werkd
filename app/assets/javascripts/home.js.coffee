#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require alerts

try
  $player = Froogaloop( $('#intro-video-player')
  if $player
    $player[0] ).addEvent('ready', ->
      f = $f($('#intro-video-player')[0])
      f.addEvent('play', ->
        console.log("playing")
        return true
      )
      window.vimeoPlayer = f
    )
catch error
  #in case vimeo craps out


$("#intro-text").on("click", ->
  $("#intro-text").hide()
  $('#intro-video-player').show()
  window.vimeoPlayer.api("play")
)

$("[data-role=existing-user]").on("click", ->
  $("#signup-form").hide()
  $("#signin-form").show()
  return
)
$("[data-role=new-user]").on("click", ->
  $("#signup-form").show()
  $("#signin-form").hide()
  return
)

