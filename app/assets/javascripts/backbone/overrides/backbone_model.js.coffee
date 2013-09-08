moduleKeywords = ['included', 'extends']

class Backbone.Model extends Backbone.Model
  @include: (obj) ->
    for key, value of obj when key not in moduleKeywords
      # Assign properties to the prototype
      @[key] = value

    obj.included?.apply(@)
    @

