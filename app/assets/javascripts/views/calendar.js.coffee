FunSchedular.CalendarsView = Ember.View.extend

  monthChanged: (->
  	@rerender()
  ).observes('controller.currentMonth')

  eventsChanged: (->
  	@rerender()
  ).observes('controller.model.length')

  didInsertElement: ->
    height = (parseInt($('body').css('height')) - 135) / $('.week').length
    $('.main-calendar .calendar .day').css('height', height)

