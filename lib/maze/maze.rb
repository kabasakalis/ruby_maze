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
                          times_visited: 0,
                          current: false,
                          previous: nil
                           )
          rooms << room
          # draw_room( room, ROOM_SIZE, 'blue' )
          # draw_all_walls(room, color)
          # left_wall = graphic.wall(room, 'left', 'red')
          # right_wall = graphic.wall(room, 'right', 'red')
          # up_wall = graphic.wall(room, 'up', 'red')
          # down_wall = graphic.wall(room, 'down', 'red')
        end
      end
      end
      public
      def find_room(x, y)
        rooms.find {|room| room.x == x &&  room.y == y}
      end

    end
  end
