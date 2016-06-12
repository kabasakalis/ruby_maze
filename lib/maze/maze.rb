# require 'maze/room'
module Maze
  class Maze
    # CON=13
    attr_accessor :rooms, :rows, :columns
    def initialize(options)
      @rooms= []
      @rows = options[:rows]

      @columns = options[:columns]
      (1..rows).each_with_index do |row|
        (1..columns).each_with_index  do |column|
          room = Room.new(x: column,
            y: row,
          )
          rooms << room
        end
      end
    end
    def find_room(position)
      rooms.find {|room| room.position == position }


    end


    def all_rooms_visited?
      rooms.all?(&:visited?)
    end

  end
end
