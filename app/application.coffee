Application =
    initialize: (onSuccess) ->
        Router = require 'lib/router'
        utils = require 'lib/utils'

        # Populated in router
        @views = {}
        @router = new Router()
        Backbone.history.start
            pushState: true

        onSuccess()
    

module.exports = Application
