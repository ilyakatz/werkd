
# User:

Werkd.Models.User.has().many('projects', {
  inverse: 'user'
  source: 'projects'
  collection: Werkd.Collections.Projects
})

Werkd.Models.User.has().many('contacts', {
  inverse: 'contactee'
  source: 'contacts'
  collection: Werkd.Collections.Users
})
