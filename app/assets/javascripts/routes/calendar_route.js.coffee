FunSchedular.CalendarsRoute = Ember.Route.extend

  model: (params) ->
    FunSchedular.Calendar.create()

  buildNewMonthState: (self, month) ->
    self.set('controller.content.guideDate', moment(month)) #set month guide date to build new month
    params = {currentMonth: moment(month).format("YYYY-MM") }
    self.transitionTo('calendars', {queryParams: params})
    height = (parseInt($('body').css('height')) - 135) / $('.week').length
    $('.main-calendar .calendar .day').css('height', height)
    self.get('controller').setAllEvents()

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

    highlightFriend: (friend) ->
      friend.set('highlighted', true)

    unHighlightFriend: (friend) ->
      friend.set('highlighted', false)

    showEvent: (event) ->
      controller = @get('controller')
      if e = controller.get('highlightedEvent')
        e.set('highlighted', false)
        
      event.set('highlighted', true)
      controller.set('highlightedEvent', event)

