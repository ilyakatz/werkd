beforeEach ->
  content = content = (html) ->
    $('#jasmine_content').append(html)
    # Werkd.onReady()
  
  # Reset the global variable instances:

  # Reset Backbone.Mediator
  # Backbone.Mediator.reset()

  # Disable dialog alerts in test mode
  window.alert = (msg) ->
    console.log("alert: #{msg}")

  # Override underscore methods:
  # _.defer = (func, args) ->
    # func(args)

  # _.delay = (func, wait, args) ->
    # func(args)

afterEach ->
  $("#jasmine_content").empty()

