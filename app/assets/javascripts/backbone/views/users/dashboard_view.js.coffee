Werkd.Views.Users ||= {}

class Werkd.Views.Users.DashboardView extends Werkd.Views.BaseView
  template: JST['backbone/templates/users/dashboard_template']

  className: 'user-dashboard-view'

  events:
    'click .user-skills li':    'onClickSkill'

  # Properties:
  
  getUser: ->
    @model

  getCurrentUser: ->
    @options.currentUser

  getProject: ->
    @getUser().getProjects().models[0] || new Werkd.Models.Project()

  getProjectModalView: ->
    @projectModalView ||= new Werkd.Views.Projects.ModalView()

  getProjectListItemViews: ->
    @projectListItemViews ||= []

  getActiveSkillTags: ->
    _.map(@getActiveSkillEls(), (skillEl) ->
      $(skillEl).text()
    )

  # View properties:

  getProjectsEl: ->
    @$el.find('.project-dashboard-list-item-views')

  getSkillsEl: ->
    @$el.find('.user-skills')

  getActiveSkillEls: ->
    @$el.find('.user-skills li.active')

  # Methods:

  filterProjects: ->
    console.log('filterProjects', @)
    activeSkillTags = @getActiveSkillTags()
    console.log('filterProjects -> activeSkillTags: ', activeSkillTags)
    _.each(@getProjectListItemViews(), (view) ->
      if view.getProject().hasAnySkills(activeSkillTags)
        view.show()
      else
        view.hide()
    )


  # Render methods:

  renderProjectModalView: (project) ->
    modalView = @getProjectModalView()
    if modalView.isNotAttached()
      @$el.parent().append(modalView.el)
      modalView.$el.offset(top: @$el.offset().top)
    modalView.setProject(project)
    modalView.setCurrentUser(@getCurrentUser())
    modalView.render()
    modalView.show()

  renderProjectListItemViews: ->
    _.each(@getUser().getProjects().models, (project) =>
      view = new Werkd.Views.Projects.DashboardListItemView(model: project)
      @getProjectListItemViews().push(view)
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
    @renderProjectModalView(project)

  onClickSkill: (event) ->
    console.log('onClickSkill', event)
    skillEl = $(event.target)
    skillEl.toggleClass('active')
    @filterProjects()

