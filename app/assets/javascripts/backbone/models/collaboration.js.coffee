class Werkd.Models.Collaboration extends Supermodel.Model
  @include Werkd.Mixins.Properties

  paramRoot: 'collaboration'

  defaults:
    id: null

  # Assocations:

  getProject: ->
    @project()

  getUser: ->
    @user()

Werkd.Models.Collaboration.initializeProperties()


class Werkd.Collections.Collaborations extends Backbone.Collection
  url: '/collaborations'
  
  model: (attrs, options) ->
    Werkd.Models.Collaboration.create(attrs, options)
