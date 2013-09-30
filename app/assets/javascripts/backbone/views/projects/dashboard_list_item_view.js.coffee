Werkd.Views.Projects ||= {}

class Werkd.Views.Projects.DashboardListItemView extends Werkd.Views.BaseView
  template: JST['backbone/templates/projects/dashboard_list_item_template']

  tagName: 'li'
  className: 'projects-dashboard-list-item-view'

  events:
    'click':      'onClickDelegate'

  # Properties:
  
  getProject: ->
    @model

  setOnClickProject: (callback) ->
    @onClickProject = callback

  # Methods:

  show: ->
    @$el.show()

  hide: ->
    @$el.hide()


  # Render methods:

  render: ->
    # console.log('render', @)
    super
    @$el.html(@template(project: @getProject())).addClass('project')
 

  # View events:

  onClickDelegate: (event) ->
    @onClickProject?(event, @getProject())
