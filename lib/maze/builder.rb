module Maze
  class Builder
    attr_reader  :maze, :path, :visited_positions

    def initialize(options)
      @maze = options[:maze]
      @path = [pos( rand(1..maze.columns ), rand(1..maze.rows))]
      @visited_positions = @path.dup
    end

    private
    def pos(x, y)
      Position.new(x, y)
    end

    def current_position
      visited_positions.last
    end

    def previous_position
      visited_positions[-2]
    end

    def go_back_to_previous_visited_room
      visited_positions.pop if visited_positions.length >= 1
    end

    def  next_position( direction, position )
      return  case direction
        when :left
          ( position.x - 1 >= 1 ) ? pos( position.x - 1, position.y ) : nil
        when :right
          ( position.x + 1 <= maze.columns ) ? pos( position.x + 1, position.y ) : nil
        when :down
          ( position.y + 1 <= maze.rows ) ? pos( position.x, position.y + 1 ) : nil
        when :up
          ( position.y - 1 >= 1 ) ? pos( position.x, position.y - 1 ) : nil
        else
          nil
        end
    end

    def room( position )
      maze.find_room position unless position.nil?
    end

    def current_room
      room current_position
    end

   DIRECTIONS.each do |direction|
      define_method "room_#{direction}" do
        room next_position(direction, current_position )
      end
    end

    def determine_direction( next_room )
      DIRECTIONS.each do |direction|
        room = self.send "room_#{ direction.to_s }"
        return direction if ( room && room.position == next_room.position )
      end
    end

    #Look for surrounding rooms that have not been built yet.
    def valid_rooms_to_build
      rooms =  DIRECTIONS.inject([]) do |valid_rooms, direction|
        _room = self.send("room_#{direction }")
        if ( _room && !_room.visited? )
          valid_rooms.push( _room )
        else
          valid_rooms
        end
      end
      previous_position.nil? ? rooms : ( rooms  - [room(previous_position)])
    end

    def build_room(_room, exit_to_free)
      _room.available_exits << exit_to_free
      _room.visits_from << exit_to_free
    end

    public
    def build_maze
      puts "Now building #{maze.rows * maze.columns} rooms for maze."
      puts "Please Wait."
      until maze.all_rooms_visited? do
        if !valid_rooms_to_build.empty?
          next_room = valid_rooms_to_build.sample
          direction = determine_direction next_room
          build_room current_room, direction
          path << next_room.position
          visited_positions << next_room.position
          build_room next_room, OPPOSITE_DIRECTION[ direction ]
        else
          go_back_to_previous_visited_room
          path << current_room.position
        end
      end
      puts "Builder Path:   #{ path.map{|p|[p.x,p.y]}.inspect}"
      puts  "Maze built  after #{path.size} steps"
    end

  end
end
