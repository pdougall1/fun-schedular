FunSchedular.Header = Ember.View.extend
  templateName: 'header'

  loginIsShowing: false
  signupIsShowing: false

  loginSucceed: ->
    @set('loginIsShowing', false)
    @set('signupIsShowing', false)

  loginFail: ->
    # @set('loginIsShowing', false)
    # @set('signupIsShowing', false)


  didInsertElement: ->
    @get('controller').on('loginDidSucceed', @, @loginSucceed)
    @get('controller').on('loginDidFail', @, @loginFail)

  actions:
    backToHome: ->
      @get('controller.target.router').transitionTo '/'

    showLogin: ->
      @set('signupIsShowing', false)
      @set('loginIsShowing', true)

    showSignup: ->
      @set('signupIsShowing', true)
