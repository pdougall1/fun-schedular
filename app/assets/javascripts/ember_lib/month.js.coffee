FunSchedular.Month = Ember.Object.extend

  # need to pass in { currentMonth: YYYY-MM }

  init: ->
    @set('guideDate', moment(@get('currentMonth'), "YYYY-MM-DD"))
    @setUpMonth()


  setUpMonth: ->
    @daysInMonth = @_getDaysInMonth()
    @allDays = @_addSurroundingDays(@daysInMonth)
    @_setDays(@allDays)
    @_orderIntoWeeks()


  guideDate: (->
    moment()
  ).property()


  month: (->
    moment(@get('guideDate')).get('month') + 1
  ).property()


  addEventsToDays: (->
    events = @get('allEvents')
    self = @
    events.forEach (event) ->
      key = event.get('date')
      day = self.get(key)
      day.addItem(event)
      self.set(key, day)

  ).observes('allEvents.length')


  allEvents: []


  ########### INTERFACE ###########

  setEvents: (events) ->
    @set('allEvents', events)
    return @


  addEvent: (event) ->
    events = @get('allEvents')
    events.addObject(event)
    @set('allEvents', events)
    return @ 


###### utilities to set u 

  _setDays: (allDays) ->
    self = @
    keys = []
    allDays.forEach (day) ->
      key = moment(day.get('moment')).format('YYYY-MM-DD')
      keys.push key
      self.set(key, day)

    @daysKeys = keys


  _getDaysInMonth: -> 
    day = @get('guideDate')
    date = moment(day).startOf('month').toDate()
    month = moment(date).get('month')
    days = []
    while date.getMonth() == month # if that date is in the right month
      day = FunSchedular.Day.create({ date: date, uniqueBy: 'id', sortProperties: 'date' })
      day.set('inMonth', true)
      days.push day
      date.setDate(date.getDate() + 1) # then advance the loop
    days



  _addSurroundingDays: (daysInMonth) ->

    # these could be more emperically defined
    firstDay = daysInMonth[0].get('moment')
    lastDay = daysInMonth[daysInMonth.length - 1].get('moment')

    # fill in next month's days
    [1..7].forEach (count) ->
      newMom = moment(lastDay).add('days', count)
      newDay = FunSchedular.Day.create({ date: newMom })
      newDay.set('month', 'previous')
      daysInMonth.push newDay if moment(lastDay).add('days', count).get('week') == moment(lastDay).get('week')

    # fill in previous month's days
    [1..7].forEach (count) ->
      newMom = moment(firstDay).subtract('days', count)
      newDay = FunSchedular.Day.create({ date: newMom })
      newDay.set('month', 'next')
      daysInMonth.push newDay if moment(newMom).get('week') == moment(firstDay).get('week')

    daysInMonth



  _orderIntoWeeks: ->
    allDays = @_getAllDays()

    callback = (acc, day) ->
      week = moment(day.get('moment')).get('week')
      console.log week
      if acc[week] 
        acc[week].push day
      else
        acc[week] = [day]
      acc

    _weeks = allDays.reduce callback, {}
    weeks = []
    for key of _weeks
      iterator = (day) -> 
        day.moment.unix()
      
      weeks.push _.sortBy(_weeks[key], iterator)
    @set('weeks', weeks)


  _getAllDays: ->
    self = @
    @daysKeys.map (key) -> 
      self.get(key)

