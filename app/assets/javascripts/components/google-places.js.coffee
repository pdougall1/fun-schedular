FunSchedular.GooglePlacesComponent = Ember.TextField.extend
  
  setupAutocomplete: (->
    self = @
    autocomplete = new google.maps.places.Autocomplete(document.getElementById(@get('elementId')))
    @set('autocomplete', autocomplete)

    callback = -> 
      googlePlace = autocomplete.getPlace()
      self.placeChange(googlePlace, self)
      
    google.maps.event.addListener(autocomplete, 'place_changed',  -> callback())
  ).on('didInsertElement')


  placeChange: (googlePlace, self) ->
    console.log(googlePlace)
    self.sendAction('action', googlePlace)