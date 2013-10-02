#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require alerts


iframe = $('#intro-video-player')[0]
player = $f(iframe)

player.addEvent('ready',->
    console.log('ready');
    player.addEvent('finish', ->
      console.log("finished")
    )
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

