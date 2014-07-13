FunSchedular.CalendarsRoute = Ember.Route.extend

  queryParams: 
    currentMonth: refreshModel: true

  model: (params) ->
    # refires upon query param changes via `queryParamsDidChange` action
    # params has format of { queryParamName: "someValueOrJustNull" }, which we can just forward to the server
    events = @store.findQuery('event', params)
    FunSchedular.Month.create(params).setEvents(events) 

  buildNewMonthState: (self, month) ->
    self.set('controller.content.guideDate', moment(month)) #set month guide date to build new month

    params = {currentMonth: moment(month).format("YYYY-MM") }
    self.transitionTo('events', {queryParams: params})

    events = self.store.findQuery('event', params)
    self.get('controller.content').setEvents(events) # set events in the new month

  actions:
    previousMonth: ->
      previousMonth = moment(@get('controller.currentMonth'), 'YYYY-MM').subtract('month', 1)
      @get('buildNewMonthState')(@, previousMonth)
      
    nextMonth: ->
      nextMonth = moment(@get('controller.currentMonth'), 'YYYY-MM').add('month', 1)
      @get('buildNewMonthState')(@, nextMonth)

    newEvent: (day) ->
      @transitionTo('events.create')
      @get('controller.createCont').set('content.date', day.get('moment').toDate())