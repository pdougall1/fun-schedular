FunSchedular.Day = Ember.ArrayProxy.extend

  # --- optional parameters ---
  # date: < date of this day >  :  this is required, can be either a moment object or a string "YYYY-MM-DD"
  # uniqueBy: < attribute name >  :  this will set the attribute that serves as criteria for unique items
  # sortProperties: < attribute name >  :  this will set the attribute that is used to keep the order of the array


  init: ->
    if moment.isMoment(@get('date'))
      date = @get('date')
    else
      date = moment(@get('date'))
    @set('today', true) if moment(date).format("YYYY-MM-DD") == moment().format("YYYY-MM-DD")
    @set('moment', date)
    @set('content', Ember.A([]))
    @itemUniqueByProps = []

  ofMonth: (->
    m = moment(@get('moment'))
    m.format('DD')
  ).property()

  inMonth: false
  month: 'current'

  formatted: (->
    moment(@get('moment')).format("YYYY-MM-DD")
  ).property('date')

  formattedDay: (->
    moment(@get('moment')).format("D")
  ).property('date')


  addItem: (item) ->
    # keep elements in content unique by their id property
    if uniqueBy = @get('uniqueBy')   
      prop = item.get(uniqueBy)
      unless @itemUniqueByProps.contains(prop)
        @itemUniqueByProps.addObject(prop)
        @addObject(item)
    else
      @addObject(item)

  removeItem: (item) ->
    newArr = @reject((i) -> item == i)
    @set('content', newArr)
    if uniqueBy = @get('uniqueBy') 
      @itemUniqueByProps = @itemUniqueByProps.reject( (prop) -> prop = item.get(prop) )



