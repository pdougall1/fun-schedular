FunSchedular.EventStripeComponent = Ember.Component.extend
  tagName: "li"  
  classNameBindings: ["color", "highlighted"]
  attributeBindings: ["style"]
    
  color: (->
    @get('property.color')
  ).property('property.color')

  highlighted: (->
    @get('property.highlighted')
  ).property('property.highlighted')

  didInsertElement: ->
    width = @$().parents('div.event-colors').width()
    @set('style', "width: #{width / @get('listLength')}px;")

  # actions:

    # submitText: ->
    #   @set('editing', false)
    #   @sendAction('submitText', @get('chosenText'))

    # editText: ->
    #   @set('editing', true)
      
