# Project factories:

projectFactory = BackboneFactory.define('project', Werkd.Models.Project, ->
  {
    title: 'Project Title'
  }
)

@createProjectModel = (options) ->
  createModel('project', options)

@createProjectModels = (count, options) ->
  createModels('project', count, options)

