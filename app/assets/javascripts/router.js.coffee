# For more information see: http://emberjs.com/guides/routing/

FunSchedular.Router.map ()->
  @resource 'events', ->
    @route 'show', { path: 'events/:event_id' }
  @resource 'calendars', { path: '/' }, ->
    @resource 'events', ->
      @route 'create'
  @resource 'users', { path: '/people' }, ->
    @route 'show', { path: '/me' }
    @route 'index', { path: '/following' }
