Werkd.Views.Users ||= {}

class Werkd.Views.Users.DashboardView extends Werkd.Views.BaseView
  template: JST['backbone/templates/users/dashboard_template']

  className: 'dashboard-view'

  # Properties:
  
  getUser: ->
    @model

  # Render methods:

  render: ->
    super
    @$el.html(@template(user: @getUser()))
  
