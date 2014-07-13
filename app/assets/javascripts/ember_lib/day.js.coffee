FunSchedular.Day = Ember.ArrayProxy.extend

  init: ->
    if moment.isMoment(@get('date'))
      date = @get('date')
    else
      date = moment(@get('date'))
    @set('today', true) if moment(date).format("YYYY-MM-DD") == moment().format("YYYY-MM-DD")
    @set('moment', date)

  ofMonth: (->
    m = moment(@get('moment'))
    m.format('DD')
  ).property()

  inMonth: false
  events: []
  month: 'current'

  # formatted: (->
  #   moment(@get('date')).format("YYYY-MM-DD")
  # ).property('date')

  # date: (->
  #   moment(@get('date')).toDate()
  # ).property()


