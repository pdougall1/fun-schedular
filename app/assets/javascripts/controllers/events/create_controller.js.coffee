FunSchedular.EventsCreateController = Ember.ObjectController.extend
  needs: ["calendars"]    

  queryParams: ['eventDate']

  eventDate: null


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
