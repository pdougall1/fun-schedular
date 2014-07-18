FunSchedular.CalendarsController = Ember.ArrayController.extend

  queryParams: ['currentMonth']

  # default query params don't show in the browser
  currentMonth: (-> 
    moment().format('YYYY-MM')
  ).property()

  showWeek: (->
    @get('content')
  ).property()

