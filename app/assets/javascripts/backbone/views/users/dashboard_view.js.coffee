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

  # View properties:

  getProjectsEl: ->
    @$el.find('.project-dashboard-list-item-views')

  # Render methods:

  renderProjectModalView: ->
    @$el.parent().append(@getProjectModalView().el)
    @getProjectModalView().render()

  renderProjectListItemViews: ->
    _.each(@getUser().getProjects().models, (project) =>
      view = new Werkd.Views.Projects.DashboardListItemView(model: project)
      view.setOnClickProject(@onClickProject)
      @getProjectsEl().append(view.el)
      view.render()
    )

  render: ->
    super
    @$el.html(@template(user: @getUser())).addClass('row-fluid')
    @renderProjectListItemViews()


  # View events:

  onClickProject: (event, project) =>
    console.log('onClickProject', arguments)
