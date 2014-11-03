window.KeyboardControls = class KeyboardControls
	constructor: (configuration) ->
		@key_configuration = configuration
		@state = {}

		for control,_ of @key_configuration
			@state[control] =
				down: false
				pressed: false
				released: false

	start: ->
		for control,button of @key_configuration
			downHandler = (ccontrol) => =>
				if !@state[ccontrol].down
					@state[ccontrol].pressed = true
					@state[ccontrol].down = true
			upHandler = (ccontrol) => =>
				if @state[ccontrol].down
					@state[ccontrol].released = true
				@state[ccontrol].down = false

			KeyboardJS.on button, downHandler(control), upHandler(control)

	reset_input: ->
		for control,state of @state
			state.pressed = false
			state.released = false

	step: () ->
		@reset_input()
