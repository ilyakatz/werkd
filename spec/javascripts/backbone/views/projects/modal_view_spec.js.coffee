createView = (args) ->
  new Werkd.Views.Projects.ModalView(args)

describe 'Werkd.Views.Projects.ModalView', ->
  beforeEach ->
    @model = createProjectModel()
    @currentUser = createUserModel()
    @view = createView()
    @view.setProject(@model)
    @view.setCurrentUser(@currentUser)
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()
  
  it 'should have model defined', ->
    expect(Werkd.Views.Projects.ModalView).toBeDefined()

  it 'can be instantiated', ->
    expect(@view).not.toBeNull()

  it 'has defaults set', ->
    expect(@view.getProject().getId()).toEqual(@model.getId())
    expect(@view.getCurrentUser().getId()).toEqual(@currentUser.getId())


  describe 'view properties', ->
    beforeEach ->
      @view.render()

    it 'should have close button', ->
      expect(@view.getCloseButtonEl()[0]).toBeDefined()

    it 'should have project image el', ->
      expect(@view.getProjectImageEl()[0]).toBeDefined()

    it 'should have background blocker', ->
      expect(@view.getBackgroundBlockerEl()[0]).toBeDefined()


  describe 'render', ->
    beforeEach ->
      @oldHtml = @view.html()
      @view.render()
      @newHtml = @view.html()

    it 'should render the template', ->
      expect(@newHtml).toNotEqual(@oldHtml)

    it 'should have display initially as none', ->
      expect(@view.$el.css('display')).toEqual('none')

  describe 'view events', ->
    beforeEach ->
      @view.render()

    describe 'onClickBackgroundBlocker', ->
      beforeEach ->
        @hide = spyOn(@view, 'hide')
        @view.getBackgroundBlockerEl().click()

      it 'should hide the moda', ->
        expect(@hide).toHaveBeenCalled()

    describe 'onClickCloseButton', ->
      beforeEach ->
        @hide = spyOn(@view, 'hide')
        @view.getCloseButtonEl().click()

      it 'should hide the moda', ->
        expect(@hide).toHaveBeenCalled()
