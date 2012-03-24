

socket = io.connect()

socket.on 'connect', () ->
	console.log 'connect'

socket.on 'statuses', (statuses) ->
	console.log statuses

socket.on 'updateStatus', (status) ->
	name = status.user.screen_name
	text = status.text
	console.log "#{name}: #{text}"

window.getStatuses = getStatuses
window.socket = socket


