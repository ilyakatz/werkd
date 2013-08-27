class Werkd.Models.User extends Backbone.Model
  @include Werkd.Mixins.Properties

  paramRoot: 'user'

  defaults:
    id:     null

Werkd.Models.User.initializeProperties()

class Werkd.Collections.UsersCollection extends Backbone.Collection
  model: Werkd.Models.User
  url: '/users'
