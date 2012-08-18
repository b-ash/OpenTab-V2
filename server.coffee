fs = require 'fs'
express = require 'express'
sysPath = require 'path'

fullPath = sysPath.resolve 'config'
{config} = require fullPath

exports.startServer = (port, path, callback) ->
  server = express.createServer express.logger()
  port = parseInt(process.env.PORT or port, 10)

  server.configure ->
    server.use express.bodyParser()
    server.use express.methodOverride()

    # Error handling
    server.use express.errorHandler
      dumpExceptions: true
      showStack: true

  server.use express.static("#{__dirname}/#{path}")
  server.listen port, -> console.log "Listening on #{port}, dawg"
  server

# We only start this up if we're not using brunch to run it. Pretty hacky, I know.
exports.startServer config.server.port, config.paths.public unless config.server.run?
