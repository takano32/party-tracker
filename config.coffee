# config.coffee
twitter_config = require './config/twitter'
accounts_config = require './config/accounts'

config =
	twitter: twitter_config
	accounts: accounts_config

module.exports = config

