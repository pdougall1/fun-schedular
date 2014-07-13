FunSchedular.GooglePlacesComponent = Ember.TextField.extend
  
  setupAutocomplete: (->
    self = @
    autocomplete = new google.maps.places.Autocomplete(document.getElementById(@get('elementId')))
    @set('autocomplete', autocomplete)

    callback = -> 
      googlePlace = autocomplete.getPlace()
      self.get('placeChange')(googlePlace, self)
      # place = FunSchedular.Place.create({googlePlace : autocomplete.getPlace()})
      
    google.maps.event.addListener(autocomplete, 'place_changed',  -> callback())
  ).on('didInsertElement')


  placeChange: (googlePlace, self) ->
    latLng = {
      lat : googlePlace.geometry.location.k
      lng : googlePlace.geometry.location.B
    }
    self.sendAction('action', latLng)