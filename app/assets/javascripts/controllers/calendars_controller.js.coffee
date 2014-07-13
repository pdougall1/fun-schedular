FunSchedular.CalendarsController = Ember.ObjectController.extend
  needs: ['eventsCreate']
  createCont: Ember.computed.alias('controllers.eventsCreate')
  queryParams: ['currentMonth']
  
  # includeEvents: (->
  #   date = moment(@get('content.guideDate')).format('TT-MM-DD')
  #   console.log "FETCH EVENTS"
  #   @store.find('event', date)
  # ).observes('content.guideDate')


  # default query params don't show in the browser
  currentMonth: (-> 
    moment().format('YYYY-MM')
  ).property()

  showWeek: (->
    @get('content')
  ).property()




