describe 'Werkd.Models.Project', ->
  beforeEach ->
    @model = new Werkd.Models.Project()
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()

  it 'should be defined', ->
    expect(Werkd.Models.Project).toBeDefined()

  it 'can be instantiated', ->
    expect(@model).not.toBeNull()

  it 'has defaults set', ->
    expect(@model.getId()).toBeNull()
    expect(@model.getTitle()).toBeNull()
    expect(@model.getThumbnailUrl()).toBeNull()


describe 'Werkd.Collections.Projects', ->
  beforeEach ->
    @collection = new Werkd.Collections.Projects()
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()

  it 'should be defined', ->
    expect(Werkd.Collections.Projects).toBeDefined()

  it 'can be instantiated', ->
    expect(@collection).not.toBeNull()

  describe 'add', ->
    beforeEach ->
      @model = createProjectModel()
      @collection.add(@model)

    it 'should add the model', ->
      expect(@collection.models[0]).toEqual(@model)
