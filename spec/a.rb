
rooms =  DIRECTIONS.inject([]) do |valid_rooms, direction|
         # binding.pry
  _room = rand(1..45)
          valid_rooms << _room if _room && !_room.visited?
      end
