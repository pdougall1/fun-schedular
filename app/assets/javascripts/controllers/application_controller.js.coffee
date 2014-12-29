FunSchedular.ApplicationController = Ember.Controller.extend Ember.Evented,

  fields: 
  	first_name: ''
  	last_name: ''
  	email: ''
  	password: ''
  	password_confirmation: ''

  userLoggedIn: (->
  	!!@get('currentUser')
  ).property('currentUser.isTrialUser')
