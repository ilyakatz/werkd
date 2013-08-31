describe 'Werkd.Models.Connection', ->
  beforeEach ->
    @model = new Werkd.Models.Connection()
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()

  it 'should be defined', ->
    expect(Werkd.Models.Connection).toBeDefined()

  it 'can be instantiated', ->
    expect(@model).not.toBeNull()

  it 'has defaults set', ->
    expect(@model.getId()).toBeNull()
    expect(@model.getPublicName()).toBeNull()
    expect(@model.getJobTitle()).toBeNull()


  describe 'associations', ->

    it 'should have user', ->
      expect(@model.getUser()).toEqual(null)


  describe 'factories', ->

    describe 'connection', ->
      beforeEach ->
        @model = createConnectionModel()

      it 'should be defined', ->
        expect(@model).toBeDefined()
        expect(@model.getUser()).toBeDefined()


describe 'Werkd.Collections.Connections', ->
  beforeEach ->
    @collection = new Werkd.Collections.Connections()
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()

  it 'should be defined', ->
    expect(Werkd.Collections.Connections).toBeDefined()

  it 'can be instantiated', ->
    expect(@collection).not.toBeNull()

  describe 'add', ->
    beforeEach ->
      @model = createConnectionModel()
      @collection.add(@model)

    it 'should add the model', ->
      expect(@collection.models[0]).toEqual(@model)
