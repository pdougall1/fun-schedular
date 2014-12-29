FunSchedular.UsersIndexController = Ember.ArrayController.extend
	needs: ['users']
	users: Ember.computed.alias("controllers.users")

	friends: (->
		@get('users.currentUser.friends')
	).property('users.currentUser.friends')

	currentUser: (->
		@get('users.currentUser')
	).property('users.currentUser')