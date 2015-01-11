FunSchedular.EventsShowRoute = Ember.Route.extend

	model: (params) ->
		@store.find('event', params['event_id'])

	actions: 
		addFriend: (friendId) ->
			self = @
			@store.find('friend', friendId).then (friend) ->
				self.get('controller.friends').pushObject friend
