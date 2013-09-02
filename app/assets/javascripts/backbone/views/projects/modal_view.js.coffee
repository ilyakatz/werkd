Werkd.Views.Projects ||= {}

class Werkd.Views.Projects.ModalView extends Werkd.Views.BaseView
  template: JST['backbone/templates/projects/modal_template']

  className: 'project-modal-view'

  events:
    'click .background-blocker':    'onClickBackgroundBlocker'


  # Properties:
  
  getProject: ->
    @model

  setProject: (project) ->
    @model = project

  # View properties:

  getBackgroundBlockerEl: ->
    @$el.find('.background-blocker')


  # Methods:

  open: ->
    console.log('open')
    @$el.css('display', 'block')

  close: ->
    console.log('close')
    @$el.css('display', 'none')


  # Render methods:

  render: ->
    super
    @$el.css('display', 'none')
    @$el.html(@template(project: @getProject()))
  

  # Events:

  onClickBackgroundBlocker: (event) ->
    console.log('onClickBackgroundBlocker', event)
    @close()
