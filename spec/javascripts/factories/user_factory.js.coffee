# User factories:

userFactory = BackboneFactory.define('user', Werkd.Models.User, ->
  {
    first_name: 'Joe'
    last_name: 'Bloggs'
  }
)

@createUserModel = (options) ->
  createModel('user', options)

@createUserModels = (count, options) ->
  createModels('user', count, options)

@createUserWithProjectsAndConnectionsModel = (options) ->
  user = createModel('user', options)
  user.getProjects().reset(createProjectModels(3))
  user.getConnections().reset(createConnectionModels(6))
  user

