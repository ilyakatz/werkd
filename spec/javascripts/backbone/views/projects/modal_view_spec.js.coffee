createView = (args) ->
  new Werkd.Views.Projects.ModalView(args)

describe 'Werkd.Views.Projects.ModalView', ->
  beforeEach ->
    @model = createProjectModel()
    @view = createView(model: @model)
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()
  
  it 'should have model defined', ->
    expect(Werkd.Views.Projects.ModalView).toBeDefined()

  it 'can be instantiated', ->
    expect(@view).not.toBeNull()

  it 'has defaults set', ->
    expect(@view.getProject()).toEqual(@model)

  describe 'render', ->
    beforeEach ->
      @oldHtml = @view.html()
      @view.render()
      @newHtml = @view.html()

    it 'should render the template', ->
      expect(@newHtml).toNotEqual(@oldHtml)
