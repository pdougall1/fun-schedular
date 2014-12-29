FunSchedular.User = DS.Model.extend

  firstName: DS.attr('string')
  lastName: DS.attr('string')
  friends: DS.hasMany('friend')
  colorKey: DS.attr('number')

  fullName: (->
    "#{@get('firstName')} #{@get('lastName')}"
  ).property('firstName', 'lastName')

  color: (->
  	@get('colorsMap')[@get('colorKey')] || 'gray'
  ).property()

  isTrialUser: (->
    "#{@get('firstName')} #{@get('lastName')}" == "Trial User"
  ).property('firstName', 'lastName')

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