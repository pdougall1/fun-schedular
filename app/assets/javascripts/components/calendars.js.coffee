FunSchedular.CalendarPickerComponent = Ember.Component.extend

  monthGuidingDate: null
  
  # daysData: (->
  #   @get('daysData')
  # ).property('daysData.@each')

  # range: (->
  #   [ 'valence-1', 'valence-2', 'valence-3', 'valence-4',
  #     'valence-5', 'valence-6', 'valence-7', 'valence-8', 'valence-9' ]
  # ).property()

  # vis_field: "clicks"

  # valenceScale: (min, max, self) ->
  #   range = 
  #   d3.scale.quantize()
  #     .domain([min, max])
  #     .range(self.get('range'))


  # findValence: (day, self) ->
  #   days = self.get('daysData').filter (row) ->
  #     dayDate = row.get('dateMoment').format('YYYY-MM-DD')
  #     d = moment(day).format('YYYY-MM-DD')
  #     dayDate == d

  #   val = 0
  #   days.forEach (day) ->
  #     val += day.get(self.get('vis_field'))
  #   val


  groupDaysByWeek: (days) ->
    callback = (acc, day) ->
      week = moment(day).get('week')
      if acc[week] 
        acc[week].push day
      else
        acc[week] = [day]
      acc

    _weeks = days.reduce callback, {}
    weeks = []
    for key of _weeks
      iterator = (day) -> day.unix()
      weeks.push _.sortBy(_weeks[key], iterator)
    weeks


  getDaysInMonth: (self) ->
    date = moment(self.get('monthGuidingDate')).toDate()
    month = moment(date).get('month')
    days = []
    while date.getMonth() == month # if that date is in the right month
      days.push new Date(date) # make it a date object and add it to days
      date.setDate(date.getDate() + 1) # then advance the loop

    days.map (day) -> 
      mom = moment(day)
      mom.inMonth = true
      mom


  # processWeeks: (weeks, self) ->
  #   processed = weeks.map (week) ->
  #     week.map (day) ->
  #       day.formattedDay = day.format('DD')
  #       day.today = true if day.format('YYYY-MM-DD') == moment().format('YYYY-MM-DD')
  #       day.chosen = true if self.get('day').format('YYYY-MM-DD') == day.format('YYYY-MM-DD')
  #       day
  #   processed


  calendarSetupData: (self)->
    firstDay = days[0]
    lastDay = days[days.length - 1]

    # fill in next month's days
    _.range(1, 7).forEach (count) ->
      newDay = moment(lastDay).add('days', count)
      days.push newDay if moment(lastDay).add('days', count).get('week') == moment(lastDay).get('week')

    # fill in previous month's days
    _.range(-7, 0).forEach (count) ->
      newDay = moment(firstDay).add('days', count)
      days.push newDay if moment(firstDay).add('days', count).get('week') == moment(firstDay).get('week')


    groupedWeeks = self.groupDaysByWeek(days)
    processedWeeks = self.get('processWeeks')(groupedWeeks, self)
    self.set('weeks', processedWeeks)

  resetCalender: (->
    @get('calendarSetupData')(@)
  ).observes('day')

  didInsertElement: ->
    day = @get('day')
    @set('monthGuidingDate', moment(day).startOf('month'))
    @set('formattedDay', day.format('D, MMM YYYY'))
    @get('calendarSetupData')(@)
    


  actions:
    chooseDate: (day) ->
      @sendAction('changeDay', day)

    previousMonth: ->
      day = @get('monthGuidingDate').subtract('month', 1)
      @set('monthGuidingDate', day)
      @set('formattedDay', day.format('D, MMM YYYY'))
      @get('calendarSetupData')(@)

    nextMonth: ->
      day = @get('monthGuidingDate').add('month', 1)
      @set('monthGuidingDate', day)
      @set('formattedDay', day.format('D, MMM YYYY'))
      @get('calendarSetupData')(@)




