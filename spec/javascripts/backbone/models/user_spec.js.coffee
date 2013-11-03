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
    expect(@model.getEmail()).toBeNull()
    expect(@model.getJobTitle()).toBeNull()
    expect(@model.getSkills()).toEqual([])

  describe 'collections', ->

    it 'should have collaborations', ->
      expect(@model.getCollaborations()).toBeDefined()
      expect(@model.getCollaborations().models).toEqual([])

    it 'should have contacts', ->
      expect(@model.getConnections()).toBeDefined()
      expect(@model.getConnections().models).toEqual([])

    it 'should have projects', ->
      expect(@model.getProjects()).toBeDefined()
      expect(@model.getProjects().models).toEqual([])

  describe 'factories', ->

    describe 'user', ->
      beforeEach ->
        @model = createUserModel()

      it 'should be defined', ->
        expect(@model).toBeDefined()
      
      it 'should have skills', ->
        expect(@model.getSkills().length).toEqual(3)

    describe 'user with collaborations and connections', ->
      beforeEach ->
        @model = createUserWithCollaborationsAndConnectionsModel()

      it 'should have collaborations', ->
        expect(@model.getCollaborations().length).toEqual(3)

      it 'should have connections', ->
        expect(@model.getConnections().length).toEqual(6)

  describe 'publicName', ->

    it 'should show generic name if name is not present', ->
      @model = createUserModel(
        first_name: null
        last_name: null
      )
      expect(@model.getPublicName()).toEqual("WeRKD User")


    it 'should show first name', ->
      @model = createUserModel(
        first_name: "ilya"
        last_name: null
      )
      expect(@model.getPublicName()).toEqual("ilya")

    it 'should show both first and last name', ->
      @model = createUserModel(
        first_name: "ilya"
        last_name: "katz"
      )
      expect(@model.getPublicName()).toEqual("ilya katz")

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
