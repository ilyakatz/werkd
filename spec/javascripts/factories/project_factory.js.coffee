# Project factories:

projectFactory = BackboneFactory.define('project', Werkd.Models.Project, ->
  {
    title: 'Project Title'
    company: 'Acme, Inc.'
    thumbnail_url: 'http://werkd.herokuapp.com/assets/werkd-a3b0f2bf6bfb587c39cd9fcf962e145d.png'
    creator: createUserModel()
    contributors: createUserModels(3)
    skills: ['Ruby', 'Backbone JS', 'CSS']
  }
)

@createProjectModel = (options) ->
  createModel('project', options)

@createProjectModels = (count, options) ->
  createModels('project', count, options)

