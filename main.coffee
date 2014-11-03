configuration =
	right: 'd'
	left: 'a'
	down: 's'
	up: 'w'
	light_punch: 'f'
	medium_punch: 't'
	heavy_punch: 'y'
	light_kick: 'v'
	medium_kick: 'g'
	heavy_kick: 'h'

combos =
	light_left_hadouken: ['down', 'left', 'light_punch']
	light_right_hadouken: ['down', 'right', 'light_punch']

controls = new KeyboardControls(configuration)
controls.start()

comboReader = new ComboReader(controls.state, combos)

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
	comboReader.step()
	controls.step()
	if comboReader.move
		console.log('Move: ' + comboReader.move)
	done()

gameLoop()
