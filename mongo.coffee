mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

exists = (value) ->
    return value? and value.length

# Schemas, bro. Schemas.
UserSchema = new Schema
    name:
        first: String
        last: String
    email: 
        type: String
        validate: [exists, 'an email is required']
        index: 
            unique: true
UserSchema.virtual('name.full').set (name) ->
    [this.name.first, this.name.last] = name.split(' ')

LocationSchema = new Schema 
    name:
        type: String
        validate: [exists, 'a name is required']
        index: 
            unique: true
    description: String
    city: String
    #geolocation: String  # Todo

TabSchema = new Schema
    amount: Number
    spenders: [ObjectId]
    owers: [ObjectId]
    where: ObjectId
    description: String
    date: Date

ActivitySchema = new Schema
    spender: ObjectId
    ower: ObjectId
    tab: ObjectId
    amount: Number
ActivitySchema.index {spender: 1, ower: 1, tab: 1}

mongoose.model 'User', UserSchema
mongoose.model 'Location', LocationSchema
mongoose.model 'Tab', TabSchema
mongoose.model 'Activity', ActivitySchema

User = mongoose.model 'User'
Location = mongoose.model 'Location'
Tab = mongoose.model 'Tab'
Activity = mongoose.model 'Activity'


class Api
    init: (server) =>
        mongoose.connect('mongodb://nodejitsu:8022ec061548f2d2d487d85b2e9959c3@alex.mongohq.com:10086/nodejitsudb180461702878')
        @serve server
        @

    # getMessages:  (req, res, next) =>
    #     Message.find().execFind (arr, data) ->
    #         res.send data

    # postMessage: (req, res, next) =>
    #     message = new Message()
    #     message.message = 'test'
    #     message.save () -> 
    #         res.send req.body

    serve: (server) =>
        # server.get '/messages', @getMessages


module.exports = Api
