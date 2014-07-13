FunSchedular.Event = DS.Model.extend

  date: DS.attr('date')
  beginTime: DS.attr('date')
  endTime: DS.attr('date')
  name: DS.attr('string')
  location: DS.attr('string')
  latitude: DS.attr('number')
  longitude: DS.attr('number')
  description: DS.attr('string')
  # friends

  # asEnglish: (->
  #   moment(@get('date')).format("MMMM DD, YYYY")
  # ).property('date')

  moment: (->
  	moment(@get('date'))
  ).property()

  dateMom: (->
  	moment(@get('date'), "YYYY-MM-DD")
  ).property()