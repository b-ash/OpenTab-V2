fs = require 'fs'
express = require 'express'
sysPath = require 'path'

fullPath = sysPath.resolve 'config'
{config} = require fullPath

exports.startServer = (port, path, callback) ->
  server = express.createServer()
  # server.all '/*', (request, response) ->
  #   response.sendfile "#{__dirname}#{path}index.html"

  server.use (request, response, next) ->
    response.header 'Cache-Control', 'no-cache'
    next()
  server.use '/', express.static path
  server.get '/', (req, res) ->
    res.sendfile "#{__dirname}/#{path}/index.html"
  port = process.env.PORT or port


  server.listen parseInt port, 10
  server.on 'listening', -> console.log "Listening on #{port}, dawg"
  server

# We only start this up if we're not using brunch to run it. Pretty hacky, I know.
exports.startServer config.server.port, config.paths.public unless config.server.run?
