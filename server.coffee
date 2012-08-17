express = require 'express'
sysPath = require 'path'

exports.startServer = (port, path, callback) ->
  server = express.createServer()
  server.use (request, response, next) ->
    response.header 'Cache-Control', 'no-cache'
    next()
  server.use '/logzilla/', express.static path
  server.all '/logzilla/*', (request, response) ->
    response.sendfile sysPath.join path, 'index.html'
  server.listen parseInt port, 10
  server.on 'listening', callback
  server
