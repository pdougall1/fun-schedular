FunSchedular.Header = Ember.View.extend
  templateName: 'header'

  actions:
    backToHome: ->
      @get('controller.target.router').transitionTo '/'

    logIn: ->
      @get('controller.target.router').transitionTo 'calendars.login'

