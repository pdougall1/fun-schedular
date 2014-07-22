FunSchedular.CalendarsRoute = Ember.Route.extend

  queryParams: 
    currentMonth: refreshModel: true

  model: (params) ->
    # refires upon query param changes via `queryParamsDidChange` action
    # params has format of { queryParamName: "someValueOrJustNull" }, which we can just forward to the server
    @set('params', params)
    @store.findQuery('event', params)

  buildNewMonthState: (self, month) ->
    self.set('controller.content.guideDate', moment(month)) #set month guide date to build new month

    params = {currentMonth: moment(month).format("YYYY-MM") }
    self.transitionTo('calendars', {queryParams: params})

    events = self.store.findQuery('event', params)
    self.get('controller.calendar').setEvents(events) # set events in the new month
    self.get('view')
    height = (parseInt($('body').css('height')) - 135) / $('.week').length
    $('.main-calendar .calendar .day').css('height', height)

  actions:
    previousMonth: ->
      previousMonth = moment(@get('controller.currentMonth'), 'YYYY-MM').subtract('month', 1)
      @get('buildNewMonthState')(@, previousMonth)
      
    nextMonth: ->
      nextMonth = moment(@get('controller.currentMonth'), 'YYYY-MM').add('month', 1)
      @get('buildNewMonthState')(@, nextMonth)

    newEvent: (day) ->
      params = { eventDate: day.get('moment').format('YYYY-MM-DD') }
      @transitionTo('events.create', { queryParams: params })



