FunSchedular.ApplicationRoute = Ember.Route.extend

  setupController: (controller) ->
    if gon.current_user
      user = @store.createRecord 'user', 
        firstName: gon.current_user.first_name
        lastName: gon.current_user.last_name
      controller.set('currentUser', user)


  actions:
    login: ->
      store = @store
      cont = @get('controller')
      data = cont.getProperties('password', 'email')
      Ember.$.post(gon.auth_path, { user: data }).then (response) ->
        if response.success 
          # still need to set an auth token
          cont.set('authToken', response.success)
          user = store.createRecord 'user', 
            firstName: response.user.first_name
            lastName: response.user.last_name
          cont.set('currentUser', user)
          cont.trigger('loginDidSucceed')
        else
          cont.set('errors', response.errors[0])
          cont.trigger('loginDidFail')
          

    logout: ->
      cont = @get('controller')
      Ember.$.ajax(
        type: "GET"
        url: gon.sign_out_path
        data: { id: cont.get('currentUser.id') }
      ).done ->
        cont.set('currentUser', null)


