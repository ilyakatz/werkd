class Werkd.Models.User extends Supermodel.Model
  @include Werkd.Mixins.Properties

  paramRoot: 'user'

  defaults:
    id: null
    first_name: null
    last_name: null
    public_name: null
    email: null
    job_title: null
    skills: []

  # Collections:

  getProjects: ->
    @projects()

  getConnections: ->
    @connections()

Werkd.Models.User.initializeProperties()

class Werkd.Collections.Users extends Backbone.Collection
  url: '/users'

  model: (attrs, options) ->
    Werkd.Models.User.create(attrs, options)
