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
						if @matchCombo(combo.moves)
								@move = combo
								@buffer.clear()
								return

				if @state.right.pressed
						@move =
								full_name: 'Right'
				else if @state.left.pressed
						@move =
								full_name: 'Left'
				else
						@move = false

		bufferMoves: ->
				pressed = []
				for name, state of @state
						pressed.push name if state.down

				if pressed.length > 0
						@buffer.push(pressed)

		matchCombo: (combo) ->
				combo = combo.slice()
				combo_length = combo.length
				moves = @buffer.moves()

				while combo_move = combo.shift()
						accepted = false
						while move = moves.shift()
								if @matchMove(combo_move,move)
										accepted = true
										break
						if !accepted
								break
						else
								combo_length -= 1

				combo_length == 0

		matchMove: (move, moves) ->
				if Array.isArray(move)
						move.every (m) -> moves.indexOf(m) > -1
				else
						moves[0] == move

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

