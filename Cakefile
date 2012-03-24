
task 'js', 'compile coffee files', (options) ->
	child_process = require 'child_process'
	exec = child_process.exec

	files_to_compile = [
		'public/javascripts/party-tracker.coffee',
	]

	cmd = "coffee -c #{files_to_compile.join ' '}"
	exec cmd, (err,stdout,stderr) ->
		throw err if err
		console.log stdout + stderr

