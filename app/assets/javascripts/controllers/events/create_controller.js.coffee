FunSchedular.EventsCreateController = Ember.ObjectController.extend

  editingDate: (->
    !@get('time')
  ).property()

  editingDate: (->
    !@get('time')
  ).property()

  editingName: (->
    !@get('name')
  ).property()

  editingLocation: (->
    !@get('location')
  ).property()
