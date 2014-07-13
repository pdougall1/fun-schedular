FunSchedular.TimeSelectorComponent = Ember.Select.extend

  content: (->
    date = @get('date') || moment()
    date.set('hour', 0)
    date.set('minute', 0)
    date.set('second', 0)
    date.set('millisecond', 0)
    content = [1..48].map (i) ->
      date.add(30, 'minute')
      { date: moment(date).toDate(), time: moment(date).format('h:mm A') }
    content
  ).property()

  optionValuePath: "content.date"
  optionLabelPath: "content.time"

  change:->
    @get('controller').send("changedTime", @get('value'), @get('type'))

  # actions:
  #   change:->
  #     console.log "CHANGED"
      # debugger