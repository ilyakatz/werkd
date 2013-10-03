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
    expect(@model.getCompany()).toBeNull()
    expect(@model.getThumbnailUrl()).toBeNull()
    expect(@model.getCloudinaryId()).toEqual(null)
    expect(@model.getEmbedHtml()).toEqual(null)
    expect(@model.getSkills()).toEqual([])


  describe 'associations', ->

    it 'should have creator', ->
      expect(@model.getCreator()).toBeUndefined()


  describe 'collections', ->

    it 'should have contributors', ->
      expect(@model.getContributors().models).toEqual([])

  describe 'methods', ->

    describe 'hasAnySkills', ->
      beforeEach ->
        @projectSkills = ['Java', 'Scala', 'Groovy', 'Ruby']
        @model.setSkills(@projectSkills)

      it 'should be true when testing for all skills', ->
        expect(@model.hasAnySkills(@projectSkills)).toEqual(true)

      it 'should be true when testing for some skills', ->
        @skills = ['Java', 'Ruby']
        expect(@model.hasAnySkills(@skills)).toEqual(true)

      it 'should be true when testing for one skill', ->
        @skills = ['Java']
        expect(@model.hasAnySkills(@skills)).toEqual(true)

      it 'should be false when testing for non skill', ->
        @skills = ['Cobol']
        expect(@model.hasAnySkills(@skills)).toEqual(false)



  describe 'factories', ->

    describe 'project', ->
      beforeEach ->
        @model = createProjectModel()

      it 'should have properties set', ->
        expect(@model.getId()).not.toBeNull()
        expect(@model.getTitle()).not.toBeNull()
        expect(@model.getCompany()).not.toBeNull()
        expect(@model.getThumbnailUrl()).not.toBeNull()
        expect(@model.getCreator()).not.toBeNull()
        expect(@model.getCloudinaryId()).not.toBeNull()
        # expect(@model.getCloudinaryId()).not.toBeNull()

      it 'should have collections set', ->
        expect(@model.getContributors().length).toEqual(3)

      it 'should have skills', ->
        expect(@model.getSkills().length).toEqual(3)


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
