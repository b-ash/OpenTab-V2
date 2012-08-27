io = require 'socket.io'

class Socket

    init: (server) =>
        @io = io.listen server
        @configure()
        @route()
        @

    configure: =>
        @io.configure =>
            @io.set 'transports', ['xhr-polling']
            @io.set 'polling duration', 10

    route: =>
        @io.sockets.on 'connection', (socket) =>
            # Add broadcast routes here


module.exports = Socket
