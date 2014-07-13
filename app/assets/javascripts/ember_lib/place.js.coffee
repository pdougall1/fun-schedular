FunSchedular.Place = Ember.Object.extend

  # must pass a google place in with the key "googlePlace"

  addressMap: {
    streetNumber : 0
    street : 1
    city : 2
    state : 3
    country : 4
    zip : 5
  }

  streetNumber: (->
    i = @get('addressMap').streetNumber
    @get('googlePlace').address_components[i]
  ).property()

  street: (->
    i = @get('addressMap').street
    @get('googlePlace').address_components[i]
  ).property()

  city: (->
    i = @get('addressMap').city
    @get('googlePlace').address_components[i]
  ).property()

  state: (->
    @get('addressMap').state
    @get('googlePlace').address_components[i]
  ).property()

  country: (->
    @get('addressMap').country
    @get('googlePlace').address_components[i]
  ).property()

  zip: (->
    @get('addressMap').zip
    @get('googlePlace').address_components[i]
  ).property()

