fs = require 'fs'
express = require 'express'
sysPath = require 'path'

fullPath = sysPath.resolve 'config'
{config} = require fullPath

exports.startServer = (port, path, callback) ->
  server = express.createServer()
  server.use (request, response, next) ->
    response.header 'Cache-Control', 'no-cache'
    next()
  server.use '', express.static path
  server.all '/*', (request, response) ->
    dir = "#{__dirname}/#{path}/index.html"
    console.log "Serving #{dir}"
    response.sendfile dir
  server.listen parseInt port, 10
  server.on 'listening', callback
  server

# We only start this up if we're not using brunch to run it. Pretty hacky, I know.
port = process.env.PORT or config.server.port
exports.startServer port, config.paths.public, -> console.log "Listening on port #{port}, dawg" unless config.server.run?
