$("[data-remote=true]").on('ajax:before', (data, status, xhr) ->
  $newDiv = $("<div>").html("Sending")
  $(@).html("<div>").html($newDiv)
)

$("[data-remote=true]").on('ajax:complete', (data, status, xhr) ->
  $newDiv = $("<div>").html("Sent")
  $(@).replaceWith($newDiv)
)
