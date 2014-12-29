FunSchedular.ApplicationRoute = Ember.Route.extend 

  setupController: (controller) ->
    if gon.current_user
      user = @store.find('user', gon.current_user.id)
      controller.set('currentUser', user)


  actions:
    login: (signingUp) ->
      store = @store
      cont = @get('controller')
      data = cont.get('fields')
      if signingUp
        path = gon.sign_up
      else
        path = gon.sign_in

      Ember.$.post(path, { user: data }).then (response) ->
        if response.success 
          # still need to set an auth token
          cont.set('authToken', response.success)
          user = store.createRecord 'user', 
            firstName: response.user.first_name
            lastName: response.user.last_name
          cont.set('currentUser', user)
          cont.trigger('loginDidSucceed')
        else
          cont.trigger('loginDidFail')
          

    logout: ->
      cont = @get('controller')
      Ember.$.ajax(
        type: "GET"
        url: gon.sign_out_path
        data: { id: cont.get('currentUser.id') }
      ).done ->
        cont.set('currentUser', null)

    visitUser: ->
      @transitionTo('users.show')

    visitUsers: ->
      @transitionTo('users.index')



