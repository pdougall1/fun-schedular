FunSchedular.CalendarsController = Ember.ArrayController.extend

  queryParams: ['currentMonth']

  # default query params don't show in the browser
  currentMonth: (-> 
    moment().format('YYYY-MM')
  ).property()

  showWeek: (->
    @get('content')
  ).property()

  calendar: (->
  	params = { currentMonth: @get('currentMonth') }
  	FunSchedular.Month.create(params).setEvents(@get('model')) 
  ).property('model.length')

  currentMonthFormatted: (->
    moment(@get('currentMonth'), 'YYYY-MM').format('MMMM YYYY')
  ).property('currentMonth')