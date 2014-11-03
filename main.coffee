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

comboReader = new ComboReader(controls.state)

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
