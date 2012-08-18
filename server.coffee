fs = require 'fs'
express = require 'express'
sysPath = require 'path'

fullPath = sysPath.resolve 'config'
{config} = require fullPath

exports.startServer = (port, path, callback) ->
  server = express.createServer express.logger()
  port = parseInt(process.env.PORT or port, 10)
  fullPath = "#{__dirname}/#{path}"

  console.log "Port #{port}, path #{path}, fullPath #{fullPath}"

  server.configure ->
    server.use express.bodyParser()
    server.use express.methodOverride()
    server.use '/', express.static(fullPath)

    # Error handling
    server.use express.errorHandler
      dumpExceptions: true
      showStack: true

  server.get '/', (req, res) ->
    res.sendfile "#{fullPath}/index.html"

  server.listen port, -> console.log "Listening on #{port}, dawg"
  server

# We only start this up if we're not using brunch to run it. Pretty hacky, I know.
exports.startServer config.server.port, config.paths.public unless config.server.run?
