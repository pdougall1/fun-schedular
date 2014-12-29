FunSchedular.CalendarsView = Ember.View.extend

  monthChanged: (->
  	@rerender()
  ).observes('controller.currentMonth')

  eventsChanged: (->
  	@rerender()
  ).observes('controller.model.length')

  didInsertElement: ->
    $('body').css('overflow', 'hidden')
    bodyHeight = parseInt($('body').css('height'))
    height = ((bodyHeight) - 135) / $('.week').length
    $('.main-calendar .calendar .day').css('height', height)
    $('#sidebar').css('height', bodyHeight - 45 - 80 - 23)
    @get('controller').setAllEvents()

