Werkd.Views.Users ||= {}

class Werkd.Views.Users.DashboardView extends Werkd.Views.BaseView
  template: JST['backbone/templates/users/dashboard_template']

  className: 'dashboard-view'

  # Properties:
  
  getUser: ->
    @model

  getProject: ->
    @getUser().getProjects().models[0] || new Werkd.Models.Project()

  getProjectModalView: ->
    @projectModalView ||= new Werkd.Views.Projects.ModalView(model: @getProject())

  # Render methods:

  renderProjectModalView: ->
    @$el.parent().append(@getProjectModalView().el)
    @getProjectModalView().render()

  render: ->
    super
    @$el.html(@template(user: @getUser())).addClass('row-fluid')
    @renderProjectModalView()
  
