# Collaboration factories:

collaborationFactory = BackboneFactory.define('collaboration', Werkd.Models.Collaboration, ->
  {
    project: createProjectModel()
    user: createUserModel()
  }
)

@createCollaborationModel = (options) ->
  createModel('collaboration', options)

@createCollaborationModels = (count, options) ->
  createModels('collaboration', count, options)

