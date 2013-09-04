Werkd.Views.Projects ||= {}

class Werkd.Views.Projects.ModalView extends Werkd.Views.BaseView
  template: JST['backbone/templates/projects/modal_template']

  className: 'project-modal-view'

  events:
    'click .close-modal a':         'onClickCloseButton'
    'click .background-blocker':    'onClickBackgroundBlocker'


  # Properties:
  
  getProject: ->
    @model

  setProject: (project) ->
    @model = project

  # View properties:

  getBackgroundBlockerEl: ->
    @$el.find('.background-blocker')

  getCloseButtonEl: ->
    @$el.find('.close-modal a')

  # Methods:

  show: ->
    console.log('open')
    # @$el.css('display', 'block')
    @$el.fadeIn()

  hide: ->
    console.log('close')
    # @$el.css('display', 'none')
    @$el.fadeOut()


  # Render methods:

  render: ->
    super
    @$el.css('display', 'none')
    @$el.html(@template(project: @getProject()))
  

  # Events:

  onClickCloseButton: (event) ->
    console.log('onClickCloseButton', event)
    @hide()

  onClickBackgroundBlocker: (event) ->
    console.log('onClickBackgroundBlocker', event)
    @hide()
