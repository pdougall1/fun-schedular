FunSchedular.CalendarsController = Ember.Controller.extend

  currentDay: (-> moment())

  currentMonth: (-> 
    FunSchedular.Month.create( { day : @get('currentDay') } )
  ).property('currentDay')

  activeDays: (->
  	[] # must maintain a property that is the composite of days with their events
  ).property()
  
  months: 'here'



