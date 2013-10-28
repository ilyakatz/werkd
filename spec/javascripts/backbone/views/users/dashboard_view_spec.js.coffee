createView = (args) ->
  new Werkd.Views.Users.DashboardView(args)

describe 'Werkd.Views.Users.DashboardView', ->
  beforeEach ->
    @model = createUserWithCollaborationsAndConnectionsModel()
    @currentUser = createUserModel()
    @view = createView(model: @model, currentUser: @currentUser)
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()
  
  it 'should have model defined', ->
    expect(Werkd.Views.Users.DashboardView).toBeDefined()

  it 'can be instantiated', ->
    expect(@view).not.toBeNull()

  it 'has defaults set', ->
    expect(@view.getUser()).toEqual(@model)
    expect(@view.getCurrentUser()).toEqual(@currentUser)

  it 'should have project modal view', ->
    expect(@view.getProjectModalView()).toBeDefined()


  describe 'view properties', ->
    beforeEach ->
      @view.render()

    it 'should have projects el', ->
      expect(@view.getProjectsEl()[0]).toBeDefined()

    it 'should have a skills el', ->
      expect(@view.getSkillsEl()[0]).toBeDefined()
      expect(@view.getSkillsEl().find('li')[0]).toBeDefined()


  describe 'render', ->
    beforeEach ->
      @oldHtml = @view.html()
      @view.render()
      @newHtml = @view.html()

    it 'should render the template', ->
      expect(@newHtml).toNotEqual(@oldHtml)

    it 'should render the projects', ->
      expect(@view.$el.find('.project').length).toEqual(3)

  describe 'view events', ->
    beforeEach ->
      @view.render()

    describe 'onClickSkill', ->
      beforeEach ->
        @filterProjects = spyOn(@view, 'filterProjects').andCallThrough()
        @skillEl1 = $(@view.getSkillEls()[0])
        @skillEl1.click()

      it 'should toggle active on the skill tag', ->
        expect(@skillEl1).toHaveClass('active')

      it 'should deactivate other skill tags', ->
        expect(@view.getActiveSkillEls().length).toEqual(1)

      it 'should call filter projects', ->
        expect(@filterProjects).toHaveBeenCalled()

      describe 'when second skill is clicked', ->
        beforeEach ->
          @skillEl2 = $(@view.getSkillEls()[1])
          @skillEl2.click()
          
        it 'should toggle active on the skill tag', ->
          expect(@skillEl2).toHaveClass('active')

        it 'should keep active on the previous skill tag', ->
          expect(@skillEl1).toHaveClass('active')

        it 'should just keep the clicked skill tags active', ->
          expect(@view.getActiveSkillEls().length).toEqual(2)





        

