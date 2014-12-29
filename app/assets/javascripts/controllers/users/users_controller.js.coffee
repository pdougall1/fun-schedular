FunSchedular.UsersController = Ember.ObjectController.extend
	needs: ['application']

	currentUser: (->
		@get('controllers.application.currentUser')
	).property('controllers.application.currentUser')