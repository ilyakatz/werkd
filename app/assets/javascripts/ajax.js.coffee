$("[data-remote=true]").on('ajax:success', (data, status, xhr) ->
  $newDiv = $("<i>").addClass("icon-ok")
  $(@).replaceWith($newDiv)
)

#no error handling for now
$("[data-remote=true]").on('ajax:error', (data, status, xhr) ->
  $newDiv = $("<i>").addClass("icon-ok")
  $(@).replaceWith($newDiv)
)
