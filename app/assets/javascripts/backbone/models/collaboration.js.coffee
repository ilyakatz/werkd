class Werkd.Models.Collaboration extends Supermodel.Model
  @include Werkd.Mixins.Properties

  paramRoot: 'collaboration'

  defaults:
    id: null
    contribution: null
    skill_list: []
    pending: false


  # Properties:

  isPending: ->
    @getPending()


  # Assocations:

  getProject: ->
    @project()

  getUser: ->
    @user()


  # Methods:
  
  hasAnySkills: (skills) ->
    if @getSkillList().length > 0
      _.intersection(@getSkillList(), skills).length > 0
    else
      true


Werkd.Models.Collaboration.initializeProperties()


class Werkd.Collections.Collaborations extends Backbone.Collection
  url: '/collaborations'
  
  model: (attrs, options) ->
    Werkd.Models.Collaboration.create(attrs, options)
