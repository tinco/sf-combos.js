window.ComboReader = class ComboReader
		constructor: (state, combos) ->
				@state = state
				@combos = combos
				@move = false
				@buffer = new MoveBuffer()

		step: ->
				@buffer.step()
				@bufferMoves()

				for name, combo of @combos
						if @matchCombo(combo)
								@move = name
								@buffer.clear()
								return

				if @state.right.pressed && @state.left.pressed
						@move = 'Right and Left'
				else if @state.right.pressed
						@move = 'Right'
				else if @state.left.pressed
						@move = 'Left'
				else
						@move = false

		bufferMoves: ->
				pressed = []
				for name, state of @state
						pressed.push name if state.pressed

				if pressed.length == 1
						@buffer.push(pressed[0])
				else if pressed.length > 1
						@buffer.push(pressed)

		matchCombo: (combo) ->
				combo = combo.slice()
				combo_length = combo.length
				moves = @buffer.moves()

				if moves.length > 0
						console.log moves.slice()

				while combo_move = combo.shift()
						accepted = false
						while move = moves.shift()
								if combo_move == move
										accepted = true
										break
						if !accepted
								break
						else
								combo_length -= 1

				combo_length == 0

class MoveBuffer
		constructor: () -> 
				@max_size = 13
				@max_age = 10
				@clear()

		clear: ->
				@buffer = []
				@time = 0

		step: ->
				@time += 1
				@buffer = @buffer.filter (e) => (@time - e.age) < @max_age

		push: (move) ->
				@buffer.push { move: move, age: @time }
				if @buffer.length > @max_size
						@buffer.shift

		moves: -> @buffer.map (e) -> e.move

