FunSchedular.CalendarPickerComponent = Ember.Component.extend

  guideDate: (->
    day = @get('eventDay') || @get('day')
    moment(day)
  ).property()

  chosenDay: (->
    moment(@get('day'))
  ).property('day')

  daysInMonth: ( -> # day can be a string or a date object
    day = @get('guideDate')
    date = moment(day).startOf('month').toDate()
    month = moment(date).get('month')
    days = []
    while date.getMonth() == month # if that date is in the right month
      day = FunSchedular.Day.create({ date: date })
      day.set('inMonth', true)
      # console.log "CHOSEN :   #{moment(this.get('chosenDay')).format('YYYY-MM-DD')}"
      # console.log "DATE : #{moment(date).format('YYYY-MM-DD')}"
      # debugger if moment(this.get('chosenDay')).format('YYYY-MM-DD') == moment(date).format('YYYY-MM-DD')
      day.set('chosen', true) if moment(this.get('chosenDay')).format('YYYY-MM-DD') == moment(date).format('YYYY-MM-DD')
      days.push day
      date.setDate(date.getDate() + 1) # then advance the loop

    days
  ).property('day.moment', 'guideDate')

  fullMonth: (->
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


  # this could either be used when the object is created or after each day object recieves associated events
  weeks: (->
    fullMonth = @get('fullMonth')
    callback = (acc, day) ->
      week = moment(day.get('moment')).get('week')
      # console.log moment(day.get('moment'))
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


  formattedDay: (->
    moment(@get('chosenDay')).format('D, MMM YYYY')
  ).property('chosenDay', 'guideDate')

  formattedMonth: (->
    moment(@get('guideDate')).format('MMMM')
  ).property('guideDate')

  didInsertElement: ->
    @set('guideDate', moment(@get('day')))
    
  actions:
    chooseDate: (day) ->
      @sendAction('chooseDate', day)

    previousMonth: ->
      day = moment(@get('guideDate')).subtract('month', 1)
      @set('guideDate', day)

    nextMonth: ->
      day = moment(@get('guideDate')).add('month', 1)
      @set('guideDate', day)




