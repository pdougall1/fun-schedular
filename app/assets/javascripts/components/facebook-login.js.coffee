FunSchedular.FacebookLoginComponent = Ember.Component.extend
	classNames: ['facebook-login']
	classNameBindings: ['loggedIn']

	loggedIn: false

	scope: ['public_profile', 'email', 'user_friends']

	initializeGraph: (->
	  _this = this
	  window.fbAsyncInit = ->
	    FB.init
	      appId: "1529099527374544"
	      xfbml: false
	      version: "v2.1"

	    _this.checkLoginState()
	    return

	  ((d, s, id) ->
	    js = undefined
	    fjs = d.getElementsByTagName(s)[0]
	    return  if d.getElementById(id)
	    js = d.createElement(s)
	    js.id = id
	    js.src = "//connect.facebook.net/en_US/sdk.js"
	    fjs.parentNode.insertBefore js, fjs
	    return
	  ) document, "script", "facebook-jssdk"
	  return
	).on("didInsertElement")

	click: ->
		if @get('loggedIn')
			@logout()
		else
			@login()

	login: -> 
		_this = @
		scope = @get('scope').join(',')
		FB.login ((response) -> 
			_this.set "loggedIn", true
			_this.sendLoginInfo(response.authResponse) if response.authResponse
		), { scope: scope }

	sendLoginInfo: (response) ->
		_this = this
		$.post "/facebook", { response: response }, (data) ->
			console.log("ERROR SENDING LOGIN INFO") unless data

	logout: -> 
		_this = @
		FB.getLoginStatus (response) -> 
			if response.authResponse
				FB.logout()
				_this.set "loggedIn", false



	checkLoginState: ->
		_this = this
		FB.getLoginStatus (response) ->
			_this.statusChangeCallback(response)

	statusChangeCallback: (response) ->
	  _this = this
	  
	  # The response object is returned with a status field that lets the
	  # app know the current login status of the person.
	  # Full docs on the response object can be found in the documentation
	  # for FB.getLoginStatus().
	  if response.status is "connected"
	    
	    # Logged into your app and Facebook.
	    _this.set "loggedIn", true
	  else if response.status is "not_authorized"
	    
	    # The person is logged into Facebook, but not your app.
	    _this.set "loggedIn", false
	  else
	    
	    # The person is not logged into Facebook, so we're not sure if
	    # they are logged into this app or not.
	    _this.set "loggedIn", false
	  return
