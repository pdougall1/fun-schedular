FunSchedular.EventsCreateRoute = Ember.Route.extend

  model: (params) ->

    @store.createRecord('event', { date: params.eventDate })

  unblur: (selector) ->
    $(selector).css
      'filter'         : 'blur(0px)',
      '-webkit-filter' : 'blur(0px)',
      '-moz-filter'    : 'blur(0px)',
      '-o-filter'      : 'blur(0px)',
      '-ms-filter'     : 'blur(0px)'

  actions:
    chooseDate: (day) ->
      controller = @get('controller')
      controller.set('date', moment(day.get('moment')).format('YYYY-MM-DD'))

    submitEventName: (name) ->
     	@get('controller').set('name', name)

    chooseLocation: (latLng) ->
      @get('controller').set('latitude', latLng.lat)
      @get('controller').set('longitude', latLng.lng)

    changedTime: (date, type) ->
      @get('controller').set("#{type}Time", date)

    cancelNewEvent: ->
      @get('controller.model').deleteRecord()
      @get('unblur')('.main-calendar')
      @transitionTo('calendars')

    createEvent: ->
      event = @get('controller.model')
      event.save()
      @get('unblur')('.main-calendar')
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

