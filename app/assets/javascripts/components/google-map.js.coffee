FunSchedular.GoogleMapComponent = Ember.Component.extend
  classNames: ['google-map']
  
  latLng: (->
    new google.maps.LatLng(@get('latitude'), @get('longitude'))
  ).property('latitude', 'longitude')

  mapOptions: (->
    {
     zoom: 13
     center: @get('latLng')
    }
  ).property('latitude', 'longitude')

  map: (->
    el = document.getElementById(@get('elementId'))
    new google.maps.Map(el, @get('mapOptions'))
  ).property('latitude', 'longitude')

  marker: (->
    options = { 
      position: @get('latLng')
      map: @get('map')
    }
    new google.maps.Marker(options)
  ).property('latitude', 'longitude')

  drawMap: (->
    @get('marker')
  ).observes('latitude', 'longitude', 'latLng')

  didInsertElement: ->
    @get('drawMap')

