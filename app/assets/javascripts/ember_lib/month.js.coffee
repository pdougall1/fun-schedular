FunSchedular.Month = Ember.Object.extend

  weeks: []

  init: ->
    daysInMonth = @getDaysInMonth(@get('days'))
    fullMonth = @addSurroundingDays(daysInMonth)
    groupedMonth = @get('groupDaysByWeek')(fullMonth)
    @set('weeks', groupedMonth)

  getDaysInMonth: (day) -> # day can be a string or a date object
    date = moment(day).toDate()
    month = moment(date).get('month')
    days = []
    while date.getMonth() == month # if that date is in the right month
      # console.log "DATE : #{date.getDate()}"
      day = FunSchedular.Day.create({ date: date })
      day.set('inMonth', true)
      days.push FunSchedular.Day.create(date)
      date.setDate(date.getDate() + 1) # then advance the loop

    days

  addSurroundingDays: (daysInMonth) ->
    # these could be more emperically defined
    firstDay = daysInMonth[0]
    lastDay = daysInMonth[daysInMonth.length - 1]

    # fill in next month's days
    [1..7].forEach (count) ->
      newMom = moment(lastDay).add('days', count)
      newDay = FunSchedular.Day.create({ date: newMom })
      daysInMonth.push newDay if moment(lastDay).add('days', count).get('week') == moment(lastDay).get('week')

    # fill in previous month's days
    [1..7].forEach (count) ->
      newMom = moment(firstDay).add('days', count)
      newDay = FunSchedular.Day.create({ date: newMom })
      daysInMonth.push newDay if moment(firstDay).add('days', count).get('week') == moment(firstDay).get('week')
    daysInMonth


  # this could either be used when the object is created or after each day object recieves associated events
  groupDaysByWeek: (days) ->
    callback = (acc, day) ->
      week = moment(day.get('moment')).get('week')
      console.log moment(day.get('moment'))
      if acc[week] 
        acc[week].push day
      else
        acc[week] = [day]
      acc

    _weeks = days.reduce callback, {}
    weeks = []
    for key of _weeks
      iterator = (day) -> 
        day.moment.unix()
      
      weeks.push _.sortBy(_weeks[key], iterator)
    weeks
    


