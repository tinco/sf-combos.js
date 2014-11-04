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
	light_left_hadouken:
		moves: ['down', 'left', 'light_punch']
		full_name: "Light Left Hadouken"
	light_right_hadouken:
		moves: ['down', ['down', 'right'], 'right', 'light_punch']
		full_name: "Light Right Hadouken"

simple_moves =
	dash_left:
		moves: ['left','left']
		full_name: "Dash Left"
	dash_right:
		moves: ['right','right']
		full_name: "Dash Right"
	move_down:
		moves: ['down','down']
		full_name: "Down"
	move_up:
		moves: ['up','up']
		full_name: "Move up"
	move_left:
		moves: ['left']
		full_name: "Left"
	move_right:
		moves: ['right']
		full_name: "Right"
	crouch:
		moves: ['down']
		full_name: "Crouch"
	jump:
		moves: ['up']
		full_name: "Jump"

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
		console.log('Move: ' + comboReader.move.full_name)
	done()

gameLoop()
