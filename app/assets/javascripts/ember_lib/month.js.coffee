FunSchedular.Month = Ember.Object.extend

  # need to pass in { currentMonth: YYYY-MM }

  init: ->
    @set('guideDate', moment(@get('currentMonth'), "YYYY-MM-DD"))
    @get('weeks')

  guideDate: (->
    moment()
  ).property()

  month: (->
    moment(@get('guideDate')).get('month') + 1
  ).property()

  daysInMonth: ( -> 
    day = @get('guideDate')
    date = moment(day).startOf('month').toDate()
    month = moment(date).get('month')
    days = []
    while date.getMonth() == month # if that date is in the right month
      day = FunSchedular.Day.create({ date: date })
      day.set('inMonth', true)
      days.push day
      date.setDate(date.getDate() + 1) # then advance the loop

    days
  ).property('guideDate')

  monthWithSurrounding: (->
    daysInMonth = @get('daysInMonth')

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
  ).property('daysInMonth')


  # this could either be used when the object is created or after a day object recieves an associated events after initial payload
  weeks: (->
    fullMonth = @get('monthWithSurrounding')
    callback = (acc, day) ->
      week = moment(day.get('moment')).get('week')
      if acc[week] 
        acc[week].push day
      else
        acc[week] = [day]
      acc

    _weeks = fullMonth.reduce callback, {}
    weeks = []
    for key of _weeks
      iterator = (day) -> 
        day.moment.unix()
      
      weeks.push _.sortBy(_weeks[key], iterator)
    weeks
  ).property('fullMonth')

  addEventsToDays: (->
    events = @get('events')
    daysWithEvents = @get('daysInMonth').map (day) ->
      events.forEach (e) -> 
        day.pushObject e if moment(e.get('moment')).format('YYYY-MM-DD') == day.get('moment').format('YYYY-MM-DD') # add event to day Array if it is on that day
      day

    @set('daysInMonth', daysWithEvents)
  ).observes('events')

  events: []


  ########### INTERFACE ###########

  setEvents: (events) ->
    @set('events', events)
    return @ #return self to chaing methods



