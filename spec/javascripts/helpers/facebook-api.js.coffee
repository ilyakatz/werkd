window.FB = (->
  self = {}

  self.init = (options) ->
    FBStub.appId options.appId

  self.login = (callback) ->
    return  unless FBStub.initialized()
    FBStub.loginCallback = callback

  self.getLoginStatus = (callback) ->
    return  unless FBStub.initialized()
    status = undefined
    authResponse = null
    if FBStub.isLoggedIn()
      if FBStub.isConnected()
        status = "connected"
        authResponse = self.getAuthResponse()
      else
        status = "not_authorized"
    else
      status = "unknown"
    callback
      status: status
      authResponse: authResponse

  self.getAuthResponse = () ->
    accessToken: ""
    expiresIn: 4095
    signedRequest: ""
    userID: FBStub.userID()

  self.api = (path, method, params, callback) ->
    callbackMethod = undefined
    if typeof method is "function"
      callbackMethod = method
    else
      if typeof params is "function"
        callbackMethod = params
      else
        callbackMethod = callback
    FBStub.addApiRequest path, callbackMethod

  self
)()

window.FBStub = (->
  self = {}
  state = undefined
  apiRequests = undefined
  initialize = ->
    state =
      loggedIn: false
      connected: false
      appId: null
      user: {}

    apiRequests = {}

  initialize()
  self.addApiRequest = (path, callback) ->
    apiRequests[path] = callback

  self.findApiRequest = (path) ->
    apiRequests[path]

  self.loggedIn = (user) ->
    state.loggedIn = true
    state.user = user or {}

  self.notLoggedIn = ->
    state.loggedIn = false
    state.user = {}

  self.connected = ->
    state.connected = true

  self.notConnected = ->
    state.connected = false

  self.isLoggedIn = ->
    state.loggedIn

  self.isConnected = ->
    state.connected

  self.userID = ->
    state.user.userID

  self.appId = (id) ->
    state.appId = id  if id
    state.appId

  self.reset = ->
    initialize()

  self.logInAndAuthorize = ->
    return  unless self.initialized()
    self.loginCallback
      status: "connected"
      authResponse:
        accessToken: ""
        userID: ""
        expiresIn: 4374
        signedRequest: ""


  self.logInAndDeny = ->
    return  unless self.initialized()
    self.loginCallback
      status: "not_authorized"
      authResponse: null


  self.abortLogIn = ->
    return  unless self.initialized()
    self.loginCallback
      status: "unknown"
      authResponse: null


  self.respondToApiRequest = (path, response) ->
    return  if typeof (apiRequests[path]) is "undefined"
    apiRequests[path] response

  self.initialized = ->
    appId = state.appId
    typeof (appId) is "number" or typeof (appId) is "string"

  self
)()
