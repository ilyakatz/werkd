Werkd.Views.Projects ||= {}

class Werkd.Views.Projects.ModalView extends Werkd.Views.BaseView
  template: JST['backbone/templates/projects/modal_template']

  className: 'project-modal-view'

  # Properties:
  
  getProject: ->
    @model

  # Render methods:

  render: ->
    super
    @$el.html(@template(project: @getProject()))
  
