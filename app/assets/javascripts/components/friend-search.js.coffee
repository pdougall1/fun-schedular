FunSchedular.FriendSearchComponent = Ember.Component.extend
  classNames: ['friend-search']
  searchText: ''

  updateFriends: (->
    self = @
    $.get '/search_suggestions', { term: @get('searchText') }, (data) -> 
      self.set('results', data)
  ).observes('searchText')

  # actions:

    # submitText: ->
    #   @set('editing', false)
    #   @sendAction('submitText', @get('chosenText'))

    # editText: ->
    #   @set('editing', true)
      
