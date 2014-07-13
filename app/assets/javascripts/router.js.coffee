# For more information see: http://emberjs.com/guides/routing/

FunSchedular.Router.map ()->
  @resource 'calendars', { path: '/' }, ->
    @resource 'events', ->
      @route 'show'
      @route 'create'
    @route 'login'
