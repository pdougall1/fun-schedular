FunSchedular.EventsCreateRoute = Ember.Route.extend

  model: (params) ->
    @store.createRecord('event', { date: params.eventDate })

  actions:
    chooseDate: (day) ->
      controller = @get('controller')
      controller.set('date', moment(day.get('moment')).format('YYYY-MM-DD'))

    submitEventName: (name) ->
     	@get('controller').set('name', name)

    chooseLocation: (googlePlace) ->
      cont = @get('controller')
      cont.set('latitude', googlePlace.geometry.location.lat())
      cont.set('longitude', googlePlace.geometry.location.lng())
      cont.set('location', googlePlace.formatted_address)


    changedTime: (date, type) ->
      @get('controller').set("#{type}Time", date)

    cancelNewEvent: ->
      @get('controller.model').deleteRecord()
      @transitionTo('calendars')

    createEvent: ->
      event = @get('controller.model')
      event.save()
      @get('controller.controllers.calendars.model').addItem(event)
      params = { currentMonth: moment(event.get('moment')).format('YYYY-MM') }
      @transitionTo('calendars', { queryParams: params } )

    showTop: ->
      $("#cube").removeClass().addClass('show-top')

    showFront: ->
      $("#cube").removeClass().addClass('show-front')

    showBottom: ->
      $("#cube").removeClass().addClass('show-bottom')

    showBack: ->
      $("#cube").removeClass().addClass('show-back')

