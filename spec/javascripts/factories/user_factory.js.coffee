# User factories:

userFactory = BackboneFactory.define('user', Werkd.Models.User, ->
  {
    first_name: 'Joe'
    last_name: 'Bloggs'
    skills: ['Ruby', 'Backbone JS', 'CSS']
  }
)

@createUserModel = (options) ->
  createModel('user', options)

@createUserModels = (count, options) ->
  createModels('user', count, options)

@createUserWithCollaborationsAndConnectionsModel = (options) ->
  user = createModel('user', options)
  user.getCollaborations().reset(createCollaborationModels(3, user: null))
  user.getConnections().reset(createConnectionModels(6))
  user

