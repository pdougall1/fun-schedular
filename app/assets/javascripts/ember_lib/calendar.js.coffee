FunSchedular.Calendar = Ember.Object.extend

  createMonth: (currentMonth) ->
    month = FunSchedular.Month.create({ currentMonth: currentMonth })
    dateKey = moment(month.get('guideDate')).format('YYYY-MM')
    @set(dateKey, month)
    month

  newItemsRepo: []

  watchNewItems: (->
    @addItems(@get('newItemsRepo.content.content'))
  ).observes('newItemsRepo.length')


  addItems: (items) ->
    self = @
    groups = @groupItems(items)
    for key, group of groups
      month = if self[key] then self[key] else self.createMonth(key)
      month.setEvents(group)
      self.set(key, month)


  groupItems: (items) ->
    self = @
    callback = (item) ->
      self.getMonthKey(item)
    _.groupBy(items, callback)


  getMonthKey: (item) ->
    item.get('date').split("-").slice(0, 2).join('-')


  addItem: (item) ->
    dateKey = moment(item.get('date')).format('YYYY-MM')
    month = @findOrCreate(dateKey)
    month.addEvent(item)
    @set(dateKey, month)

  findOrCreate: (dateKey) ->
    if month = @get('dateKey') 
      month
    else 
      @createMonth(dateKey)
