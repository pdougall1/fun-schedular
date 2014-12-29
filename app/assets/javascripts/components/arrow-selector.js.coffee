FunSchedular.ArrowSelectorComponent = Ember.Component.extend

	resetValue: (operation, alternate) ->
		vals = [0..@get('max')].map (n) -> n
		newVal = vals[operation(@get('value'))]
		unless newVal
			newVal = alternate
			if @get('value') == @get('max')
				@sendAction('passMax')
			else
				@sendAction('belowMax')
		@set('value', newVal)

	
	actions:
		increase: ->
			@resetValue( ((val) -> val + 1), 1)

		decrease: ->
			@resetValue( ((val) -> val - 1 ), @get('max'))

