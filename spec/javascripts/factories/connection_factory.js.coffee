# Connection factories:

connectionFactory = BackboneFactory.define('connection', Werkd.Models.Connection, ->
  {
    first_name: 'Joe'
    last_name: 'Bloggs'
    user: createUserModel()
  }
)

@createConnectionModel = (options) ->
  createModel('connection', options)

@createConnectionModels = (count, options) ->
  createModels('connection', count, options)

