express = require "express"
app = express.createServer()
coffee = require "coffee-script"

io = require("socket.io").listen app

app.use express.static(__dirname + "/public")
app.register ".haml",require("hamljs")
app.get "/", (req,res) ->
    res.render "index.html.haml"

app.listen process.env.PORT || 3000
