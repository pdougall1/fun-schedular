FunSchedular.CalendarsController = Ember.ObjectController.extend
  queryParams: ['currentMonth']
  needs: ['application']
  highlightedEvent: null

  currentUser: (->
    @get('controllers.application.currentUser')
  ).property('controllers.application.currentUser')

  # default query params don't show in the browser bar
  currentMonth: (-> 
    moment().format('YYYY-MM')
  ).property()

  showWeek: (->
    @get('content')
  ).property()

  currentMonthObj: (->
    currentMonth = @get('currentMonth')
    @get(currentMonth) || @get('content').createMonth(currentMonth)
  ).property('currentMonth')

  setAllEvents: ->
    events = @store.findQuery('event', { currentMonth: @get('currentMonth') })
    @get('content').set("newItemsRepo", events)


  currentMonthFormatted: (->
    moment(@get('currentMonth'), 'YYYY-MM').format('MMMM YYYY')
  ).property('currentMonth')