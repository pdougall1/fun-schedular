FunSchedular.Event = DS.Model.extend

  date: DS.attr('string')
  beginTime: DS.attr('string')
  endTime: DS.attr('string')
  name: DS.attr('string')
  location: DS.attr('string')
  latitude: DS.attr('number')
  longitude: DS.attr('number')
  description: DS.attr('string')

  asEnglish: (->
    moment(@get('date')).format("MMMM DD, YYYY")
  ).property('date')

  moment: (->
  	moment(@get('date'))
  ).property('date')

  dateMom: (->
    moment(@get('date'), "YYYY-MM-DD")
  ).property('date')

  dateBegin: (->
    moment(@get('date'), "YYYY-MM-DDThh:mm:ss")
  ).property('date')

  dateEnd: (->
    moment(@get('date'), "YYYY-MM-DDThh:mm:ss")
  ).property('date')

