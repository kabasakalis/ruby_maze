require 'maze/room'
require 'maze/maze'
Position = Struct.new( :x, :y)
module Maze
  class Builder
    # CON=13
    attr_accessor  :maze, :current_position, :previous_position, :path
    def initialize(options)
      @maze = options[:maze]
      @current_position = Position.new( rand(1..maze.columns ), rand(1..maze.rows)) # =>
      path = [ current_position ]
      @previous_position =   Position.new
    end
    public

    # Maze::EXITS.each do |exit|
    #   define_method "#{exit}?" do
    #     return true if available_exits.include?(exit)
    #     return false
    #   end
    # end
    def room( position )
      maze.find_room position.x, position.y
    end
    def current_room
      room current_position
    end


    def  next_position( direction, position)
      return  case direction
        when :left
          ( position.x - 1 >= 0 ) ? Position.new( position.x - 1, position.y ) : nil
        when :right
          ( position.x + 1 <= maze.columns ) ? Position.new( position.x + 1, position.y ) : nil
        when :down
          ( position.y + 1 <= maze.rows ) ? Position.new( position.x, position.y + 1 ) : nil
        when :up
          ( position.y + 1 <= 0 ) ? Position.new( position.x, position.y - 1 ) : nil
        else
        end
    end


    [ :left, :up, :right, :down ].each do |direction|
      define_method "room_#{direction}" do
        room next_position(direction, current_position)
      end
    end

    def valid_rooms_to_build
      [ :left, :up, :right, :down ].inject([]) do |valid_rooms, direction|
        room = self.send("room_#{direction }"
        valid_rooms << room if room && !room.visited?
        valid_rooms - [room(previous_position)] if room(previous_position)
      end

    end

  end
end
