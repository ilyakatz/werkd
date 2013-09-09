class Werkd.Views.BaseView extends Backbone.View

  # Properties:
  
  isAttached: ->
    @$el.parent().length != 0

  isNotAttached: ->
    !@isAttached()

  html: ->
    @$el.html()
