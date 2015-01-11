FunSchedular.FriendSearchComponent = Ember.Component.extend
  classNames: ['friend-search']
  searchText: ''

  updateResults: (->
    self = @
    $.get '/search_suggestions', { term: @get('searchText') }, (data) -> 
      friends = data.map (f) -> JSON.parse(f)
      self.set('results', friends)
  ).observes('searchText')

  actions:

    addFriend: (friendId) ->
      @sendAction 'action', friendId
      
