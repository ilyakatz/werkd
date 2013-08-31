describe 'Werkd.Models.User', ->
  beforeEach ->
    @model = new Werkd.Models.User()
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()

  it 'should be defined', ->
    expect(Werkd.Models.User).toBeDefined()

  it 'can be instantiated', ->
    expect(@model).not.toBeNull()

  it 'has defaults set', ->
    expect(@model.getId()).toBeNull()
    expect(@model.getFirstName()).toBeNull()
    expect(@model.getLastName()).toBeNull()

  describe 'collections', ->

    it 'should have projects', ->
      expect(@model.getProjects()).toBeDefined()
      expect(@model.getProjects().models).toEqual([])

    it 'should have contacts', ->
      expect(@model.getConnections()).toBeDefined()
      expect(@model.getConnections().models).toEqual([])

  describe 'factories', ->

    describe 'user', ->
      beforeEach ->
        @model = createUserModel()

      it 'should be defined', ->
        expect(@model).toBeDefined()

    describe 'user with projects and connections', ->
      beforeEach ->
        @model = createUserWithProjectsAndConnectionsModel()

      it 'should have projects', ->
        expect(@model.getProjects().length).toEqual(3)




describe 'Werkd.Collections.Users', ->
  beforeEach ->
    @collection = new Werkd.Collections.Users()
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()

  it 'should be defined', ->
    expect(Werkd.Collections.Users).toBeDefined()

  it 'can be instantiated', ->
    expect(@collection).not.toBeNull()

  describe 'add', ->
    beforeEach ->
      @model = createUserModel()
      @collection.add(@model)

    it 'should add the model', ->
      expect(@collection.models[0]).toEqual(@model)
