
window.google = {}
window.google.maps = {}
window.google.maps.places = {}


class google.maps.InfoWindow


class google.maps.LatLng
  latitude: null
  longitude: null

  constructor: (lat, lng) ->
    @latitude = lat
    @longitude = lng

  lat: ->
    @latitude

  lng: ->
    @longitude


class google.maps.LatLngBounds

  constructor: (sw, ne) ->
    @sw = sw
    @ne = ne

  isEmpty: ->
    false

  getNorthEast: ->
    @ne

  getSouthWest: ->
    @sw

  extend: (latLng) ->
    if latLng instanceof google.maps.LatLng
      latLng = [latLng.lng(), latLng.lat()]
    bounds = createLatLngBounds(latLng, latLng)
    @union(bounds)

  union: (latLngBounds) ->
    if @sw? && @ne?
      swLat = _.min([latLngBounds.sw.lat(), @sw.lat()])
      swLng = _.min([latLngBounds.sw.lng(), @sw.lng()])
      @sw = createLatLng(swLat, swLng)
      
      neLat = _.max([latLngBounds.ne.lat(), @ne.lat()])
      neLng = _.max([latLngBounds.ne.lng(), @ne.lng()])
      @ne = createLatLng(neLat, neLng)
    else
      @sw = latLngBounds.sw
      @ne = latLngBounds.ne
    

class google.maps.Map
  center: new google.maps.LatLng(0, 0)

  constructor: (mapDiv, options = {}) ->
    @mapDiv = mapDiv
    @setOptions(options)

  # Properties:
  
  fitBounds: (bounds) ->
    @bounds = bounds

  getBounds: ->
    @bounds

  setCenter: (center) ->
    @center = center

  getCenter: ->
    @center
  
  setOptions: (options) ->
    @options = options
    _.extend(@, options)

  getOptions: ->
    @options

  setZoom: (zoom) ->
    @zoom = zoom

  getZoom: ->
    @zoom

  # Methods:

  panTo: (latLng) ->
    @setCenter(latLng)


class google.maps.MapTypeId

  @ROADMAP: 'ROADMAP'


class google.maps.Marker
  
  constructor: (options) ->
    if options?
      _.extend(@, options)

  getTitle: ->
    @title

  setMap: (map) ->
    @map = map

  getMap: ->
    @map

  lat: ->
    @position.lat()

  lng: ->
    @position.lng()

  setPosition: (latLng) ->
    @position = latLng

  getPosition: ->
    @position


class google.maps.MarkerImage

  constructor: (url, size, origin, anchor, scaledSize) ->
    @url = url
    @size = size
    @origin = origin
    @anchor = anchor
    @scaledSize = scaledSize


class google.maps.MVCArray

  constructor: (array) ->
    @array = array

  getArray: ->
    @array


class google.maps.OverlayView


class google.maps.Point

  constructor: (x, y) ->
    @x = x
    @y = y


class google.maps.Polygon
  options: null
  paths: null

  constructor: (options = {}) ->
    @options = {paths: [[]]}
    @setOptions(options)

  getBounds: ->
    createLatLngBounds()

  setMap: (map) ->
    @map = map

  setOptions: (options) ->
    @options = _.extend(@options, options)
    if @options.paths? && @options.paths[0] instanceof Array
      if @options.paths[0].length > 0
        tempPaths = [_.map @options.paths, (path) ->
          new google.maps.MVCArray(path)
        ]
      else
        tempPaths = [new google.maps.MVCArray([])]
    else if @options.paths? && @options.paths.length > 0
      tempPaths = [new google.maps.MVCArray(@options.paths)]
    else
      tempPaths = [new google.maps.MVCArray([])]
    @paths = new google.maps.MVCArray(tempPaths)
    @latLngs = @paths

  getPaths: ->
    @paths

  getPath: ->
    @getPaths().getArray()[0]


class google.maps.Rectangle

  constructor: (options = {}) ->
    @options = options

  getBounds: ->
    @options.bounds


class google.maps.Size

  constructor: (width = 0, height = 0) ->
    @width = width
    @height = height


class google.maps.event

  @addListener: (mapObject, eventName, callback) ->
    @listeners ||= []
    @listeners.push([mapObject, eventName, callback])

  @addListenerOnce: (args) ->

  @trigger: (args) ->


class google.maps.places.Autocomplete


class google.maps.places.AutocompleteService

  constructor: ->

  getQueryPredictions: (request, callback) ->
    console.log('getQueryPredictions', request)

  getPlacePredictions: (request, callback) ->
    console.log('getPlacePredictions', request)


class google.maps.places.PlacesService

  textSearch: (request, callback) ->
    console.log('textSearch', request)

  getDetails: (request, callback) ->
    console.log('getDetails', request)


# Helper methods:

@createLatLng = (lat = 0, lng = 0) ->
  new google.maps.LatLng(lat, lng)

@createLatLngBounds = (sw = [0, 0], ne = [1, 1]) ->
  sw = createLatLng(sw[1], sw[0])
  ne = createLatLng(ne[1], ne[0])
  new google.maps.LatLngBounds(sw, ne)

@createMarkerClusterer = (map, markers, options) ->
  new MarkerClusterer(map, markers, options)

@createPoint = (x, y) ->
  new google.maps.Point(x, y)

@createRectangle = (sw, ne) ->
  bounds = createLatLngBounds(sw, ne)
  new google.maps.Rectangle({bounds: bounds})

@createSize = (width, height) ->
  new google.maps.Size(width, height)
