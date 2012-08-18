fs = require 'fs'
express = require 'express'
sysPath = require 'path'

fullPath = sysPath.resolve 'config'
{config} = require fullPath

exports.startServer = (port, path, callback) ->
  server = express.createServer()
  fullPath = "#{__dirname}/#{path}"
  #io.listen server
  # server.all '/*', (request, response) ->
  #   response.sendfile "#{__dirname}#{path}index.html"

  console.log "Port #{port}, path #{path}, fullPath #{fullPath}"
  server.configure ->
    server.use express.bodyParser()
    server.use express.methodOverride()
    server.use server.router
    server.use express.static(fullPath)

    # Error handling
    server.use express.errorHandler
      dumpExceptions: true
      showStack: true

  server.get '/', (req, res) ->
    res.sendfile "./#{path}/index.html"

  port = parseInt(process.env.PORT or port, 10)
  server.listen port
  server.on 'listening', -> console.log "Listening on #{port}, dawg"

  server

# We only start this up if we're not using brunch to run it. Pretty hacky, I know.
exports.startServer config.server.port, config.paths.public unless config.server.run?
