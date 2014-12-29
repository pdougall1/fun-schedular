FunSchedular.EventBarComponent = Ember.Component.extend
  classNames: ['event-bar']
  classNameBindings: ['isHighlighted']

  isHighlighted: (-> 
      return @get('event.highlighted')
  ).property('event.highlighted')

  click: ->
    @sendAction('action', @get('event'))
    console.log('event clicked')

  # actions:

    # submitText: ->
    #   @set('editing', false)
    #   @sendAction('submitText', @get('chosenText'))

    # editText: ->
    #   @set('editing', true)
      
