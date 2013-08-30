class Werkd.Models.Project extends Supermodel.Model
  @include Werkd.Mixins.Properties

  paramRoot: 'project'

  defaults:
    id: null
    title: null

Werkd.Models.Project.initializeProperties()


class Werkd.Collections.Projects extends Backbone.Collection
  url: '/projects'

  model: (attrs, options) ->
    Dabtab.Models.Project.create(attrs, options)
