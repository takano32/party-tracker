
statuses = []

socket = io.connect()

socket.on 'connect', () ->
	console.log 'connect'

socket.on 'statuses', (statuses) ->
	console.log statuses

socket.on 'updateStatuses', (inStatuses) ->
	if inStatuses == null
		return
	for status in inStatuses
		statuses.push(status)
	# ordering by status.created_at
	statuses.sort(compareDate)
	# ToDo reduce li element
	###
	max = 40
	if max < statuses.length
		statuses = statuses[-max..-1]
	###
	$('#timeline > li').remove()
	for status in statuses
		prependStatus(status)

socket.on 'streamingUpdateStatus', (status) ->
	prependStatus(status)

prependStatus = (status) ->
	name = status.user.screen_name
	text = status.text
	tweet = "#{name}: #{text}"
	console.log tweet
	$('#timeline').prepend($('<li>').text(tweet))

compareDate = (a, b) ->
	ad = new Date(a.created_at)
	bd = new Date(b.created_at)
	return ad - bd

