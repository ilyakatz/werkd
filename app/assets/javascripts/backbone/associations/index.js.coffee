
# User:

Werkd.Models.User.has().many('projects', {
  inverse: 'user'
  source: 'projects'
  collection: Werkd.Collections.Projects
})

Werkd.Models.User.has().many('connections', {
  inverse: 'connectee'
  source: 'connections'
  collection: Werkd.Collections.Connections
})


# Connection:

Werkd.Models.Connection.has().one('user', {
  inverse: 'connections'
  source: 'user'
  model: Werkd.Models.User
})
