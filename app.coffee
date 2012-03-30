#! /usr/bin/env coffee
# ntwitter http://d.hatena.ne.jp/replication/20120318/1332044327
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
eco = require 'eco'
app.register '.eco', eco

app.get '/', (req,res) ->
	res.render 'index.html.eco'

app.listen process.env.PORT || 3000
io = require('socket.io').listen app

io.sockets.on('connection', (socket) ->
	console.log 'connection'
	sendStatuses(socket)
)

sendStatuses = (socket) ->
	ids = []
	for id, account of config.accounts
		ids.push(account.twitter)

	for id in ids
		twitter.getUserTimeline({id: id}, (err, statuses) ->
			console.log err
			socket.emit('updateStatuses', statuses)
		)

	id_strs = []
	twitter.showUser(ids.join, (err, users) ->
		console.log err
		for user in users
			console.log user.id_str
			id_strs.push(user.id_str)
		streamingStatuses()
	)

	streamingStatuses = () ->
		twitter.stream('statuses/filter', {follow: id_strs.join()}, (stream) ->
			stream.on('data', (status) ->
				socket.emit('streamingUpdateStatus', status)
			)
		)



