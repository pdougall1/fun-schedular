FunSchedular.EventsCreateRoute = Ember.Route.extend
  model: ->
    @store.createRecord('event')

  actions:
    chooseDate: (day) ->
      controller = @get('controller')
      controller.set('date', day.get('moment').toDate())
      controller.set('editingDate', false)

    editDate: ->
      @get('controller').set('editingDate', true)

    submitEventName: (name) ->
     	@get('controller').set('name', name)

    chooseLocation: (latLng) ->
      @get('controller').set('latitude', latLng.lat)
      @get('controller').set('longitude', latLng.lng)

    createEvent: ->
      @get('controller.model').save()

    changedTime: (date, type) ->
      @get('controller').set("#{type}Time", date)

