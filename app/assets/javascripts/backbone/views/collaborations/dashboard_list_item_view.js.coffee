Werkd.Views.Collaborations ||= {}

class Werkd.Views.Collaborations.DashboardListItemView extends Werkd.Views.BaseView
  template: JST['backbone/templates/projects/dashboard_list_item_template']

  tagName: 'li'
  className: 'projects-dashboard-list-item-view'

  events:
    'click':      'onClickDelegate'

  # Properties:
  
  getCollaboration: ->
    @model

  getProject: ->
    @getCollaboration().getProject()

  setOnClickCollaboration: (callback) ->
    @onClickCollaboration = callback

  getImageUrl: ->
    if cloudinaryId = @getProject().getCloudinaryId()
      $.cloudinary.url(cloudinaryId, {width: 304, height: 171, crop: 'fill'})
    else
      '/assets/werkd.png'

  # Methods:

  show: ->
    @$el.show()

  hide: ->
    @$el.hide()


  # Render methods:

  render: ->
    # console.log('render', @)
    super
    @$el.html(@template(view: @)).addClass('project')
 

  # View events:

  onClickDelegate: (event) ->
    @onClickCollaboration?(event, @getCollaboration())
