configuration =
	right: 'd'
	left: 'a'
	down: 's'
	up: 'w'
	pierce_attack: 'f'
	hack_attack: 't'
	deflect_attack: 'y'

controls = new KeyboardControls(configuration)
controls.start()

gameLoop = ->
	step = 1/60 * 1000
	looper = ->
		previous = Date.now()
		gameStep ->
			now = Date.now()
			elapsed = now - previous
			previous = now
			setTimeout(looper, step - elapsed)
	looper()

gameStep = (done) ->
	done()

gameLoop()
