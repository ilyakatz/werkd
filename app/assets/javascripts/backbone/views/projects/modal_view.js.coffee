Werkd.Views.Projects ||= {}

class Werkd.Views.Projects.ModalView extends Werkd.Views.BaseView
  template: JST['backbone/templates/projects/modal_template']

  className: 'project-modal-view'

  events:
    'click .close-modal a':         'onClickCloseButton'
    'click .background-blocker':    'onClickBackgroundBlocker'

  initialize: ->
    @currentUser = @options.currentUser
    @initViewBindings()

  initViewBindings: ->
    $(window).resize(@onWindowResize)

  # Properties:
  
  getProject: ->
    @model

  setProject: (project) ->
    @model = project

  getCurrentUser: ->
    @currentUser

  setCurrentUser: (currentUser) ->
    @currentUser = currentUser

  # View properties:

  getBackgroundBlockerEl: ->
    @$el.find('.background-blocker')

  getCloseButtonEl: ->
    @$el.find('.close-modal a')

  getProjectImageEl: ->
    @$el.find('.project-details img.main')

  # Methods:

  show: ->
    console.log('open')
    # @$el.css('display', 'block')
    @$el.fadeIn()
    @resizeProjectImage()

  hide: ->
    console.log('close')
    # @$el.css('display', 'none')
    @$el.fadeOut()

  resizeProjectImage: ->
    width = @getProjectImageEl().width()
    console.log('resizeProjectImage', width)
    @getProjectImageEl().height(9.0/16.0 * width)


  # Render methods:

  render: ->
    super
    @$el.css('display', 'none')
    @$el.html(@template(project: @getProject(), currentUser: @getCurrentUser()))
  

  # View Events:
  
  onWindowResize: (event) =>
    console.log('onWindowResize', event)
    @resizeProjectImage()

  onClickCloseButton: (event) ->
    console.log('onClickCloseButton', event)
    @hide()

  onClickBackgroundBlocker: (event) ->
    console.log('onClickBackgroundBlocker', event)
    @hide()
