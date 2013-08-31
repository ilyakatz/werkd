class Werkd.Models.Connection extends Supermodel.Model
  @include Werkd.Mixins.Properties

  paramRoot: 'connection'

  defaults:
    id: null
    public_name: null
    job_title: null

  # Assocations:

  getUser: ->
    @user()

Werkd.Models.Connection.initializeProperties()


class Werkd.Collections.Connections extends Backbone.Collection
  url: '/connections'
  
  model: (attrs, options) ->
    Werkd.Models.Connection.create(attrs, options)
