fs = require 'fs'
express = require 'express'
sysPath = require 'path'

fullPath = sysPath.resolve 'config'
{config} = require fullPath

exports.startServer = (port, path, callback) ->
  server = express.createServer()
  # server.all '/*', (request, response) ->
  #   response.sendfile "#{__dirname}#{path}index.html"

  server.configure () ->
    server.use express.static("#{__dirname}/#{path}")
    server.use express.bodyParser()
    server.use express.methodOverride()

    # Error handling
    server.use express.logger()
    server.use express.errorHandler
      dumpExceptions: true
      showStack: true

      server.use server.router

  server.get '/', (req, res) ->
    res.render "#{path}/index.html"

  port = parseInt(process.env.PORT or port, 10)
  server.listen port
  server.on 'listening', -> console.log "Listening on #{port}, dawg"
  server

# We only start this up if we're not using brunch to run it. Pretty hacky, I know.
exports.startServer config.server.port, config.paths.public unless config.server.run?
