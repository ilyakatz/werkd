#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require alerts


iframe = $('#intro-video-player')[0]
player = $f(iframe)
window.vimeo_player = player

player.addEvent('ready',->
    console.log('ready');
    player.addEvent('finish', ->
      $("iframe").hide()
      $("#play-intro-button").show()
    )
)

$("#play-intro-button").on("click", ->
  $("iframe").show().css("margin-bottom", "-5px")
  $(@).hide()
  window.vimeo_player.api("play")
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

