#! /usr/bin/env coffee
# see also http://d.hatena.ne.jp/replication/20120318/1332044327
# eco http://thechangelog.com/post/1174993103/eco-embedded-coffeescript-templates
config = require './config'
express = require 'express'
coffee = require 'coffee-script'

twitter = require 'ntwitter'
twitter = new twitter
	consumer_key: config.twitter['consumer_key'],
	consumer_secret: config.twitter['consumer_secret'],
	access_token_key: config.twitter['access_token_key'],
	access_token_secret: config.twitter['access_token_secret'],

app = express.createServer()

app.use express.static(__dirname + '/public')
app.register '.haml',require('hamljs')
app.get '/', (req,res) ->
    res.render 'index.html.haml'

app.listen process.env.PORT || 3000
socket = require('socket.io').listen app

