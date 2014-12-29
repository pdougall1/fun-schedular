FunSchedular.TimeSelectorComponent = Ember.Component.extend

  value: (->
    moment()
  ).property()

  ampm: (->
    moment(@get('value')).format('A')
  ).property()

  hour: (->
    parseInt(moment(@get('value')).format('hh'))
  ).property()

  minutes: (->
    moment(@get('value')).minutes()
  ).property()

  resetValue: (->
    mom = moment(@get('value'))
    mom.hour(@get('hour'))
    mom.minutes(@get('minutes'))
    @set('value', mom)
  ).observes('hour', 'minutes')

  change:->
    @get('controller').send("changedTime", @get('value'), @get('type'))

  actions: 
    flipAmpm: ->
      if @get('ampm') == 'AM'
        @set('ampm', 'PM')
      else
        @set('ampm', 'AM')

    increaseHour: ->
      @set('hour', @get('hour') + 1)

    decreaseHour: ->
      @set('hour', @get('hour') - 1)

