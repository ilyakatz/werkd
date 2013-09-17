class Werkd.Models.Project extends Supermodel.Model
  @include Werkd.Mixins.Properties

  paramRoot: 'project'

  defaults:
    id: null
    title: null
    company: null
    thumbnail_url: null
    skills: []

  # Associations:

  getCreator: ->
    @creator()

  # Collections:

  getContributors: ->
    @contributors()


Werkd.Models.Project.initializeProperties()


class Werkd.Collections.Projects extends Backbone.Collection
  url: '/projects'

  model: (attrs, options) ->
    Werkd.Models.Project.create(attrs, options)
