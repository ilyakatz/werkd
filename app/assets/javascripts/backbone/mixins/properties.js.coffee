class Werkd.Mixins.Properties

  @initializeProperties: ->
    prototype = @::
    _.each(_.keys(prototype.defaults), (prop) =>
      getPropName = @camelCase("get_" + prop)
      setPropName = @camelCase("set_" + prop)
      if typeof(prototype[getPropName]) != 'function'
        prototype.__defineGetter__(getPropName, () ->
          () ->
            @get(prop)
        )
      if typeof(prototype[setPropName]) != 'function'
        prototype.__defineGetter__(setPropName, () ->
          (value) ->
            @set(prop, value)
        )
      )

  @camelCase: (name) ->
    name.toLowerCase().replace /_(.)/g, (match, group) ->
     group.toUpperCase()

