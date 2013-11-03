createView = (args) ->
  new Werkd.Views.Collaborations.DashboardListItemView(args)

describe 'Werkd.Views.Collaborations.DashboardListItemView', ->
  beforeEach ->
    @model = createCollaborationModel()
    @view = createView(model: @model)
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()
  
  it 'should have model defined', ->
    expect(Werkd.Views.Collaborations.DashboardListItemView).toBeDefined()

  it 'can be instantiated', ->
    expect(@view).not.toBeNull()

  it 'has defaults set', ->
    expect(@view.getCollaboration()).toEqual(@model)

  describe 'properties', ->

    describe 'imageUrl', ->
      
      describe 'when there is a cloudinary id', ->
        beforeEach ->
          @cloudinaryId = '12345678.jpg'
          @model.getProject().setCloudinaryId(@cloudinaryId)
          @imageUrl = @view.getImageUrl()

        it 'should have a cloudinary image url', ->
          expect(@imageUrl).toMatch(/.*12345678\.jpg/)
      
      describe 'when there is no cloudinary id', ->
        beforeEach ->
          @model.getProject().setCloudinaryId(null)
          @imageUrl = @view.getImageUrl()

        it 'should have a default werked image url', ->
          expect(@imageUrl).toEqual('/assets/werkd.png')
          

  describe 'view properties', ->
    beforeEach ->
      @view.render()

  describe 'render', ->
    beforeEach ->
      @oldHtml = @view.html()
      @view.render()
      @newHtml = @view.html()

    it 'should render the template', ->
      expect(@newHtml).toNotEqual(@oldHtml)

    it 'should be correct tag', ->
      expect(@view.el.tagName).toEqual('LI')

    it 'should be correct classes', ->
      expect(@view.$el).toHaveClass('project')


  describe 'view events', ->
    beforeEach ->
      @view.render()

    describe 'onClick', ->
      beforeEach ->
        @onClickCollaboration = (event, project) =>
          @clickEvent = event
          @project = project
        @view.setOnClickCollaboration(@onClickCollaboration)
        @view.$el.click()

      it 'should call onClickCollaboration', ->
        expect(@clickEvent).toBeDefined()
        expect(@project.getId()).toEqual(@model.getId())

