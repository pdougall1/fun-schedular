FunSchedular.EditableTextComponent = Ember.Component.extend

  editing: (->
    !@get('text')
  ).property()

  chosenText: (->
    @get('text')
  ).property('text')


  actions:

    submitText: ->
      @set('editing', false)
      @sendAction('submitText', @get('chosenText'))

    editText: ->
      @set('editing', true)
      
