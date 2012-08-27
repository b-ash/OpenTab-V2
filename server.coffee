fs = require 'fs'
express = require 'express'
sysPath = require 'path'

Socket = require './socket'
Db = require './mongo'

fullPath = sysPath.resolve 'config'
{config} = require fullPath

exports.startServer = (port, path, callback) ->
    server = express.createServer express.logger()
    port = parseInt(process.env.PORT or port, 10)

    # Express init
    server.configure ->
        server.use express.bodyParser()
        server.use express.methodOverride()

        # Error handling
        server.use express.errorHandler
            dumpExceptions: true
            showStack: true

    # Serve our static assets
    server.use express.static("#{__dirname}/#{path}")

    api = new Db().init server
    io = new Socket().init server

    # Serve it up!
    server.listen port, -> console.info "Listening on #{port}, dawg"
    server

# We only start this up if we're not using brunch to run it. Pretty hacky, I know.
exports.startServer config.server.port, config.paths.public unless config.server.run?
