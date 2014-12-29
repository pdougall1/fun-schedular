FunSchedular.EventsCreateController = Ember.ObjectController.extend
  needs: ["calendars"]    

  queryParams: ['eventDate']

  eventDate: null

  beginTime: (->
    moment()
  ).property()

  allCompleted: (->
    !!@get('name') &&
    !!@get('beginTime') &&
    !!@get('endTime') &&
    !!@get('latitude') &&
    !!@get('longitude')
  ).property('name', 'beginTime', 'endTime', 'latitude', 'longitude')

  buttons: (->
   [
    {
      label: 'Name'
      action: 'showBottom'
      completed: !!@get('name')
    }, {
      label: 'Beginning'
      action: 'showFront'
      completed: !!@get('beginTime')
    }, {
      label: 'Ending'
      action: 'showTop'
      completed: !!@get('endTime')
    }, {
      label: 'Location'
      action: 'showBack'
      completed: !!@get('latitude') && !!@get('longitude')
    }, {
      label: 'Submit'
      action: 'createEvent'
      completed: @get('allCompleted')
    }
  ]
  ).property('name', 'beginTime', 'endTime', 'latitude', 'longitude', 'allCompleted')



#   editingDate: (->
#     !@get('time')
#   ).property()

#   editingDate: (->
#     !@get('time')
#   ).property()

#   editingName: (->
#     !@get('name')
#   ).property()

#   editingLocation: (->
#     !@get('location')
#   ).property()
