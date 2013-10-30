class Werkd.Models.Collaboration extends Supermodel.Model
  @include Werkd.Mixins.Properties

  paramRoot: 'collaboration'

  defaults:
    id: null
    skill_list: []


  # Assocations:

  getProject: ->
    @project()

  getUser: ->
    @user()


  # Methods:
  
  hasAnySkills: (skills) ->
    _.intersection(@getSkillList(), skills).length > 0


Werkd.Models.Collaboration.initializeProperties()


class Werkd.Collections.Collaborations extends Backbone.Collection
  url: '/collaborations'
  
  model: (attrs, options) ->
    Werkd.Models.Collaboration.create(attrs, options)
