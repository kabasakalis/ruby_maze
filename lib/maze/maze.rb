require 'maze/room'
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
          room = Room.new(x: row,
                          y: column,
                           )
          rooms << room
        end
      end
      end
      public
      def find_room(x, y)
        rooms.find {|room| room.x == x &&  room.y == y}
      end

    end
  end
