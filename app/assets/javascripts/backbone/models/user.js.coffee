class Werkd.Models.User extends Supermodel.Model
  @include Werkd.Mixins.Properties

  paramRoot: 'user'

  defaults:
    id: null
    first_name: null
    last_name: null
    email: null
    job_title: null
    skills: []

  # Collections:

  getCollaborations: ->
    @collaborations()

  getConnections: ->
    @connections()

  getProjects: ->
    @projects()

  #Name as can be displayed on the site
  getPublicName: ->
    if @getFirstName() || @getLastName()
      _.compact([@getFirstName(), @getLastName()]).join(" ")
    else
      "WeRKD User"

Werkd.Models.User.initializeProperties()

class Werkd.Collections.Users extends Backbone.Collection
  url: '/users'

  model: (attrs, options) ->
    Werkd.Models.User.create(attrs, options)
