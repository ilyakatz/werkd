describe 'Werkd.Models.Collaboration', ->
  beforeEach ->
    @model = new Werkd.Models.Collaboration()
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()

  it 'should be defined', ->
    expect(Werkd.Models.Collaboration).toBeDefined()

  it 'can be instantiated', ->
    expect(@model).not.toBeNull()

  it 'has defaults set', ->
    expect(@model.getId()).toBeNull()


  describe 'associations', ->

    it 'should have project', ->
      expect(@model.getProject()).toEqual(null)

    it 'should have user', ->
      expect(@model.getUser()).toEqual(null)


  describe 'factories', ->

    describe 'collaboration', ->
      beforeEach ->
        @model = createCollaborationModel()

      it 'should be defined', ->
        expect(@model).toBeDefined()
        expect(@model.getProject()).toBeDefined()
        expect(@model.getUser()).toBeDefined()


describe 'Werkd.Collections.Collaborations', ->
  beforeEach ->
    @collection = new Werkd.Collections.Collaborations()
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()

  it 'should be defined', ->
    expect(Werkd.Collections.Collaborations).toBeDefined()

  it 'can be instantiated', ->
    expect(@collection).not.toBeNull()

  describe 'add', ->
    beforeEach ->
      @model = createCollaborationModel()
      @collection.add(@model)

    it 'should add the model', ->
      expect(@collection.models[0]).toEqual(@model)
