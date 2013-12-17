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
    expect(@model.getContribution()).toBeNull()
    expect(@model.getSkillList()).toEqual([])
    expect(@model.getPending()).toEqual(false)


  describe 'properties', ->

    describe 'pending', ->

      it 'should set and get', ->
        @model.setPending(true)
        expect(@model.isPending()).toEqual(true)


  describe 'associations', ->

    it 'should have project', ->
      expect(@model.getProject()).toEqual(null)

    it 'should have user', ->
      expect(@model.getUser()).toEqual(null)

  describe 'methods', ->

    describe 'hasAnySkills', ->
      beforeEach ->
        skills = ['Java', 'Scala', 'Groovy', 'Ruby']
        @model.setSkillList(skills)

      it 'should be true when testing for all skills', ->
        skills = ['Java', 'Scala', 'Groovy', 'Ruby']
        expect(@model.hasAnySkills(skills)).toEqual(true)

      it 'should be true when testing for some skills', ->
        skills = ['Java', 'Ruby']
        expect(@model.hasAnySkills(skills)).toEqual(true)

      it 'should be true when testing for one skill', ->
        skills = ['Java']
        expect(@model.hasAnySkills(skills)).toEqual(true)

      it 'should be false when testing for non skill', ->
        skills = ['Cobol']
        expect(@model.hasAnySkills(skills)).toEqual(false)

      describe 'when there are no skills on the project', ->
        beforeEach ->
          @model.setSkillList([])

        it 'should always be true', ->
          skills = ['Java', 'CSS']
          expect(@model.hasAnySkills(skills)).toEqual(true)

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
