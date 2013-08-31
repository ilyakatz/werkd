createView = (args) ->
  new Werkd.Views.Users.DashboardView(args)

describe 'Werkd.Views.Users.DashboardView', ->
  beforeEach ->
    @model = createUserWithProjectsAndConnectionsModel()
    @view = createView(model: @model)
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()
  
  it 'should have model defined', ->
    expect(Werkd.Views.Users.DashboardView).toBeDefined()

  it 'can be instantiated', ->
    expect(@view).not.toBeNull()

  it 'has defaults set', ->
    expect(@view.getUser()).toEqual(@model)

  describe 'render', ->
    beforeEach ->
      @oldHtml = @view.html()
      @view.render()
      @newHtml = @view.html()

    it 'should render the template', ->
      expect(@newHtml).toNotEqual(@oldHtml)
