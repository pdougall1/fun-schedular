FunSchedular.Day = Ember.Object.extend

  init: ->
    if moment.isMoment(@get('date'))
      date = @get('date')
    else
      date = moment(@get('date'))
    @set('moment', date)

  inMonth: false

  events: []