# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

FunSchedular.ApplicationStore = DS.Store.extend({

})

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
FunSchedular.ApplicationAdapter = DS.ActiveModelAdapter.extend({

})

# FunSchedular.EventsAdapter = DS.ActiveModelAdapter.extend
#   find: (store, type, id) ->
#     id = "foo" + id
#     @_super(store, type, id)

# FunSchedular.ApplicationSerializer = DS.ActiveModelSerializer.extend({})