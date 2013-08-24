#= require_self
# require ./date_factory

# Sequences:

numberSequence = BackboneFactory.define_sequence('number', (n) -> n)

coordsSequence = BackboneFactory.define_sequence('coords', (n) ->
  {lat: 40.1 + n, lng: -73.1 + n}
)

dateSequence = BackboneFactory.define_sequence('date', (n) ->
  @date ||= new Date()
  days = @date.getDate()
  new Date(@date.getYear(), @date.getMonth(), days + n)
)

@createDateString = (date) ->
  year = date.getFullYear()
  month = if (m = date.getMonth() + 1) < 10 then "0#{m}" else "#{m}"
  day = if (d = date.getDate()) < 10 then "0#{d}" else "#{d}"
  "#{year}-#{month}-#{day}"

dateStringSequence = BackboneFactory.define_sequence('date_strings', (n) ->
  date = BackboneFactory.next('date')
  createDateString(date)
)

polygonCoordsSequence = BackboneFactory.define_sequence('polygon_coords', (n) ->
  coord1 = {lat: 40.1 + n, lng: -73.1 + n}
  [coord1, {lat: 40.2 + n+1, lng: -73.2 + n+1}, {lat: 40.2 + n+2, lng: -73.0 + n+2}, coord1]
)

randomOrder = ->
  Math.round((Math.random()-0.5)*2)

firstNameSequence = BackboneFactory.define_sequence('first_name', (n) ->
  names = ['Peter', 'Paul', 'Mary']
  names.sort(-> randomOrder())
  names[0]
)

lastNameSequence = BackboneFactory.define_sequence('last_name', (n) ->
  names = ['Smith', 'Doe', 'Ray']
  names.sort(-> randomOrder())
  names[0]
)

timeSequence = BackboneFactory.define_sequence('time', (n) ->
  "#{(n % 12) + 1}:00 PM"
)

@createTimeWithDate = (time, date = new Date()) ->
  dateString = createDateString(date)
  dateString = "#{dateString} #{time} GMT-0400 (EDT)"
  new Date(dateString)

@createDateTimeString = (date) ->
  $.format.date(date, 'yyyy-MM-ddTHH:mm:ss-04:00')

# Factories:

@createModel = (factory, options) ->
  BackboneFactory.create(factory, -> options)

@createModels = (factory, count, options) ->
  BackboneFactory.create_list(factory, count, -> options)


# User Saved Events:

# eventFactory = BackboneFactory.define('user_saved_event', Dabtab.Models.UserSavedEvent, ->
  # {
    # user: createUserModel()
    # event: createEventModel()
  # }
# )

# @createUserSavedEventModel = (options) ->
  # createModel('user_saved_event', options)

# @createUserSavedEventModels = (count, options) ->
  # createModels('user_saved_event', count, options)

