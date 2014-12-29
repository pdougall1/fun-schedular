FunSchedular.Header = Ember.View.extend
  templateName: 'header'

  loggingIn: false
  signupIsShowing: false

  loginSucceed: ->
    @set('loggingIn', false)
    @set('signupIsShowing', false)

  loginFail: ->
    @set('loginFailed', false)
    # @set('signupIsShowing', false)


  didInsertElement: ->
    @get('controller').on('loginDidSucceed', @, @loginSucceed)
    @get('controller').on('loginDidFail', @, @loginFail)

  actions:
    backToHome: ->
      @get('controller.target.router').transitionTo '/'

    toggleLogin: ->
      @set('signupIsShowing', false)
      if @get('loggingIn')
        @set('loggingIn', false)
      else
        @set('loggingIn', true)

    toggleSignup: ->
      if @get('signingUp')
        @set('signingUp', false)
      else
        @set('signingUp', true)
