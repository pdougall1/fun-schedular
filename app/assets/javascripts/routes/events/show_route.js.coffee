FunSchedular.EventsShowRoute = Ember.Route.extend

	model: (params) ->
		@store.find('event', params['event_id'])