FunSchedular.FriendBarComponent = Ember.Component.extend
  # classNameBindings: ["friendColor"]

  # friendColor: (->
  #   @get('friend.color')
  # ).property('friend.color')

  mouseEnter: (e) ->
    @sendAction('sendMouseEnter', @get('friend'))

  mouseLeave: (e) ->
    @sendAction('sendMouseLeave', @get('friend'))


