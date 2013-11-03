Werkd.Views.Collaborations ||= {}

class Werkd.Views.Collaborations.ModalView extends Werkd.Views.BaseView
  template: JST['backbone/templates/collaborations/modal_template']

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

  getCollaboration: ->
    @model

  setCollaboration: (project) ->
    @model = project

  getProject: ->
    @getCollaboration().getProject()

  getCurrentUser: ->
    @currentUser

  setCurrentUser: (currentUser) ->
    @currentUser = currentUser

  getImageUrl: ->
    if cloudinaryId = @getProject().getCloudinaryId()
      $.cloudinary.url(cloudinaryId, {width: 621, height: 350, crop: 'fill'})
    else
      '/assets/werkd.png'

  getMediaContainerContent: ->
    if @getProject().hasEmbedHtml()
      content = $(@getProject().getEmbedHtml())
      content.css(width: '100%', height: '100%')
      content
    else
      $("<img class=\"main\" src=\"#{@getImageUrl()}\" />")

  # View properties:

  getBackgroundBlockerEl: ->
    @$el.find('.background-blocker')

  getCloseButtonEl: ->
    @$el.find('.close-modal a')

  getProjectImageEl: ->
    @$el.find('.project-details img.main')

  getMediaContainerEl: ->
    @$el.find('.media-container')


  # Methods:

  show: ->
    console.log('open')
    # @$el.css('display', 'block')
    @$el.fadeIn()
    @resizeMediaContainer()

  hide: ->
    console.log('close')
    # @$el.css('display', 'none')
    @$el.fadeOut()
    @getMediaContainerEl().html('')

  resizeMediaContainer: ->
    width = @getMediaContainerEl().width()
    console.log('resizeMediaContainer', width)
    @getMediaContainerEl().height(9.0/16.0 * width)


  # Render methods:

  render: ->
    super
    @$el.css('display', 'none')
    @$el.html(@template(view: @))
    @renderMediaContainer()

  renderMediaContainer: ->
    @getMediaContainerEl().html(@getMediaContainerContent())


  # View Events:

  onWindowResize: (event) =>
    console.log('onWindowResize', event)
    @resizeMediaContainer()

  onClickCloseButton: (event) ->
    console.log('onClickCloseButton', event)
    @hide()

  onClickBackgroundBlocker: (event) ->
    console.log('onClickBackgroundBlocker', event)
    @hide()
