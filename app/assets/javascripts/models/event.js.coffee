FunSchedular.Event = DS.Model.extend

  date: DS.attr('string')
  beginTime: DS.attr('string')
  endTime: DS.attr('string')
  name: DS.attr('string')
  location: DS.attr('string')
  latitude: DS.attr('number')
  longitude: DS.attr('number')
  description: DS.attr('string')
  friends: DS.hasMany('friend')
  highlighted: DS.attr('boolean', { default: false })

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

  properties: (->
    self = @
    @get('friends').map (friend) ->
      color = self.get('colorsMap')[friend.get('colorKey')]
      highlighted = friend.get('highlighted')
      { color: color, highlighted: highlighted }
  ).property('friends.@each.highlighted')

  friendsCount: (->
    @get('friends.length')
  ).property('friends')

  colorsMap: 
    1 : 'brownmadder'
    2 : 'maroon'
    3 : 'orangered4'
    4 : 'tomato4'
    5 : 'coral1'
    6 : 'chocolate'
    7 : 'cadmiumorange'
    8 : 'ochre'
    9 : 'mustard'
    10: 'brightgold'
    11: 'goldgreen'
    12: 'pea'
    13: 'chartreuse3'
    14: 'blue'
    15: 'deepskyblue2'
    16: 'aquamarine'
    17: 'sgilight'