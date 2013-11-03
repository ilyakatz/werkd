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

  getCollaboration: ->
    @getUser().getCollaborations().models[0] || new Werkd.Models.Collaboration()

  getCollaborationModalView: ->
    @projectModalView ||= new Werkd.Views.Collaborations.ModalView()

  getCollaborationListItemViews: ->
    @projectListItemViews ||= []

  getActiveSkillTags: ->
    _.map(@getActiveSkillEls(), (skillEl) ->
      $(skillEl).text()
    )


  # View properties:

  getCollaborationsEl: ->
    @$el.find('.collaboration-dashboard-list-item-views')

  getSkillsEl: ->
    @$el.find('.user-skills')

  getSkillEls: ->
    @$el.find('.user-skills li')

  getActiveSkillEls: ->
    @$el.find('.user-skills li.active')


  # Methods:

  allSkillsAreActive: ->
    @getSkillEls().length > 0 && @getSkillEls().length == @getActiveSkillEls().length

  filterCollaborations: ->
    console.log('filterCollaborations', @)
    activeSkillTags = @getActiveSkillTags()
    console.log('filterCollaborations -> activeSkillTags: ', activeSkillTags)
    _.each(@getCollaborationListItemViews(), (view) ->
      if view.getCollaboration().hasAnySkills(activeSkillTags)
        view.show()
      else
        view.hide()
    )


  # Render methods:

  renderCollaborationModalView: (collaboration) ->
    modalView = @getCollaborationModalView()
    if modalView.isNotAttached()
      @$el.parent().append(modalView.el)
      modalView.$el.offset(top: @$el.offset().top)
    modalView.setCollaboration(collaboration)
    modalView.setCurrentUser(@getCurrentUser())
    modalView.render()
    modalView.show()

  renderCollaborationListItemViews: ->
    _.each(@getUser().getCollaborations().models, (collaboration) =>
      view = new Werkd.Views.Collaborations.DashboardListItemView(model: collaboration)
      @getCollaborationListItemViews().push(view)
      view.setOnClickCollaboration(@onClickCollaboration)
      @getCollaborationsEl().append(view.el)
      view.render()
    )

  render: ->
    super
    @$el.html(@template(user: @getUser())).addClass('row-fluid')
    @renderCollaborationListItemViews()


  # View events:

  onClickCollaboration: (event, collaboration) =>
    console.log('onClickCollaboration', arguments)
    @renderCollaborationModalView(collaboration)

  onClickSkill: (event) ->
    console.log('onClickSkill', event)
    skillEl = $(event.target)
    if @allSkillsAreActive()
      @getSkillEls().toggleClass('active')
    skillEl.toggleClass('active')
    @filterCollaborations()

