createView = (args) ->
  new Werkd.Views.Users.DashboardView(args)

describe 'Werkd.Views.Users.DashboardView', ->
  beforeEach ->
    @model = createUserWithProjectsAndConnectionsModel()
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


  describe 'render', ->
    beforeEach ->
      @oldHtml = @view.html()
      @view.render()
      @newHtml = @view.html()

    it 'should render the template', ->
      expect(@newHtml).toNotEqual(@oldHtml)

    it 'should render the projects', ->
      expect(@view.$el.find('.project').length).toEqual(3)
