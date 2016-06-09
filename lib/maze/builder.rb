# require 'maze/room'
# require 'maze/maze'
module Maze
  class Builder
    OPPOSITE_DIRECTION = { left: :right, up: :down, right: :left, down: :up}
    DIRECTIONS = OPPOSITE_DIRECTION.keys
    attr_accessor  :maze, :path, :path_without_revisits
    def initialize(options)
      @maze = options[:maze]
      @path = [Position.new( rand(1..maze.columns ), rand(1..maze.rows))]
      @path_without_revisits = @path
    end

    def room( position )
      maze.find_room position.x, position.y unless position.nil?
    end
    def current_room
      room current_position
    end

    def previous_position
      path_without_revisits[ path_without_revisits.length - 2  ] if path_without_revisits.length > 1
    end


    def current_position
      path_without_revisits.last

    end

    def  next_position( direction, position)
      return  case direction
    when :left
      ( position.x - 1 >= 1 ) ? Position.new( position.x - 1, position.y ) : nil
    when :right
      ( position.x + 1 <= maze.columns ) ? Position.new( position.x + 1, position.y ) : nil
    when :down
      ( position.y + 1 <= maze.rows ) ? Position.new( position.x, position.y + 1 ) : nil
    when :up
      ( position.y - 1 >= 1 ) ? Position.new( position.x, position.y - 1 ) : nil
    else
    end
  end


  DIRECTIONS.each do |direction|
    define_method "room_#{direction}" do
      room next_position(direction, current_position )
    end
  end

  def valid_rooms_to_build
   rooms =  DIRECTIONS.inject([]) do |valid_rooms, direction|
      # binding.pry
      _room = self.send("room_#{direction }")
      if ( _room && !_room.visited? )
        valid_rooms.push( _room )
      else
        valid_rooms
      end
     end
   previous_position.nil? ? rooms : ( rooms  - [room(previous_position)])
   # binding.pry
     # unless previous_position.nil?
      #  return  (rooms  - [room(previous_position)])
      # end
  end

  def build_next_room( next_room, exit_to_free)
    # k path[path.find_index(path[path.length-2])]
    path << next_room.position
    path_without_revisits << next_room.position
    current_room.available_exits << exit_to_free
    current_room.visits_from << exit_to_free
  end

  def determine_direction( next_room)
    DIRECTIONS.each do |direction|
      room = self.send "room_#{direction.to_s}"
      return direction if (room && room.position == next_room.position)
    end
  end
  public
  def build_maze
    while !maze.all_rooms_visited? do
      # binding.pry
      if !valid_rooms_to_build.empty?
        next_room = valid_rooms_to_build.sample
        direction = determine_direction next_room
        current_room.available_exits << direction
        build_next_room next_room, OPPOSITE_DIRECTION[ direction ]
      else
        path_without_revisits.pop if path_without_revisits.length >= 1
      end
    end
  end

end
end
