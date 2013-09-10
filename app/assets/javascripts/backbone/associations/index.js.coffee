# Connection:

Werkd.Models.Connection.has().one('user', {
  inverse: 'connections'
  source: 'user'
  model: Werkd.Models.User
})


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


# Project:

Werkd.Models.Project.has().one('creator', {
  inverse: 'created_projects'
  source: 'creator'
  model: Werkd.Models.User
}

Werkd.Models.Project.has().many('contributors', {
  inverse: 'contributed_projects'
  source: 'contributors'
  collection: Werkd.Collections.Users
}))

