
    OPPOSITE_DIRECTION = { left: :right, up: :down, right: :left, down: :up}
    DIRECTIONS = OPPOSITE_DIRECTION.keys
rooms =  DIRECTIONS.inject([]) do |valid_rooms, direction|
         # binding.pry
  valid_rooms # => [], [6], [6, 45], [6, 45, 30]

  _room = rand(1..45)
          valid_rooms << _room if _room && true
      end
rooms # => [6, 45, 30, 22]



