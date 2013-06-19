$("[data-remote=true]").on('ajax:complete', (data, status, xhr) ->
  $newDiv = $("<i>").addClass("icon-ok")
  $(@).replaceWith($newDiv)
)
