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


ids = []
for id, account of config.accounts
	ids.push(id)

id_strs = []
twitter.showUser(ids, (err, users) ->
	for user in users
		id_strs.push(user.id_str)
	displayTimeline()
)

displayTimeline = () ->
	twitter.stream('statuses/filter', {follow: id_strs.join()}, (stream) ->
		stream.on('data', (data) ->
			name = data.user.screen_name
			text = data.text
			console.log "#{name}: #{text}"
		)
	)

app = express.createServer()

app.use express.static(__dirname + '/public')
eco = require 'eco'
app.register '.eco', eco

app.get '/', (req,res) ->
    res.render 'index.html.eco'

app.listen process.env.PORT || 3000
socket = require('socket.io').listen app

