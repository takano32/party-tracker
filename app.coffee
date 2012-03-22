config = require "./config"
express = require "express"
coffee = require "coffee-script"

twitter = require "ntwitter"
twitter = new twitter
	consumer_key: config.twitter["consumer_key"],
	consumer_secret: config.twitter["consumer_secret"],
	access_token_key: config.twitter["access_token_key"],
	access_token_secret: config.twitter["access_token_secret"],

app = express.createServer()

app.use express.static(__dirname + "/public")
app.register ".haml",require("hamljs")
app.get "/", (req,res) ->
    res.render "index.html.haml"

app.listen process.env.PORT || 3000
socket = require("socket.io").listen app

