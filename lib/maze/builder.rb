require 'maze/room'
require 'maze/maze'
Position = Struct.new( :x, :y)
module Maze
  class Builder
    # CON=13
    attr_accessor  :maze, :current_position, :previous_position
    def initialize(options)
      @maze = options[:maze]
      @current_position = Position.new( rand(1..maze.columns ), rand(1..maze.rows)) # =>
      # @previous_position  Position.new
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

    def move( direction )
      check_next_room direction
      case direction
      when :left
        current_position.x -= 1
      when :right
        current_position.x += 1
      when :down
        current_position.y += 1
      when :up
        current_position.y -= 1
      else
      end
    end

    def check_next_room (direction)
      next_room_position = case direction
        when :left
          Position.new( current_position.x - 1, current_position.y )
        when :right
          Position.new( current_position.x + 1, current_position.y )
        when :down
          Position.new( current_position.x, current_position.y + 1 )
        when :up
          Position.new( current_position.x, current_position.y - 1 )
        else
        end
      next_room = room next_room_position
    end


  end
end
