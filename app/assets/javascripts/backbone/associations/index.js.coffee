# Connection:

Werkd.Models.Connection.has().one('user', {
  inverse: 'connections'
  source: 'user'
  model: Werkd.Models.User
})


# Collaboration:

Werkd.Models.Collaboration.has().one('user', {
  inverse: 'collaborations'
  source: 'user'
  model: Werkd.Models.User
})

Werkd.Models.Collaboration.has().one('project', {
  inverse: 'collaborations'
  source: 'project'
  model: Werkd.Models.Project
})


# User:

Werkd.Models.User.has().many('connections', {
  inverse: 'connectee'
  source: 'connections'
  collection: Werkd.Collections.Connections
})

Werkd.Models.User.has().many('collaborations', {
  inverse: 'user'
  source: 'collaborations'
  collection: Werkd.Collections.Collaborations
})

Werkd.Models.User.has().many('projects', {
  inverse: 'user'
  source: 'projects'
  collection: Werkd.Collections.Projects
})


# Project:

Werkd.Models.Project.has().one('creator', {
  inverse: 'created_projects'
  source: 'creator'
  model: Werkd.Models.User
})

Werkd.Models.Project.has().many('contributors', {
  inverse: 'contributed_projects'
  source: 'contributors'
  collection: Werkd.Collections.Users
})

Werkd.Models.Project.has().many('pendingContributors', {
  inverse: 'contributed_projects'
  source: 'pending_contributors'
  collection: Werkd.Collections.Users
})


