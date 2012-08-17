app = require 'application'
utils = require 'lib/utils'


module.exports = class Router extends Backbone.Router
    routes:
        '*action' : 'index'

    index: =>
        # Do something fun
