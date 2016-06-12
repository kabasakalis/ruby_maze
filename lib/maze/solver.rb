
# require 'maze/room'
#
# require 'maze/maze'
module Maze
  class Solver < Builder

    attr_accessor  :maze, :path, :visited_positions, :starting_position, :goal_position
    def initialize(options)

      @maze = options[:maze]
      @starting_position = options[:starting_position]
      @goal_position = options[:goal_position]
      @path = [ @starting_position ]
      @visited_positions = @path.dup
    end

    def reset_rooms_visits_from
      maze.rooms.each { |room| room.visits_from = []}
    end
    # def available_next_rooms
    #   rooms =  DIRECTIONS.inject([]) do |next_rooms, direction|
    #     _room = self.send("room_#{direction }")
    #     if ( _room && _room.send "#{OPPOSITE_DIRECTION[direction].to_s}?") )
    #       next_rooms.push( _room )
    #     else
    #       next_rooms
    #     end
    #   end
    #   previous_position.nil? ? next_rooms : ( next_rooms  - [room(previous_position)])
    # end


    def available_exits_to_move_forward
      current_room.available_exits - [ current_room.visits_from.last ]
    end


    def best_move
      see_through_next_exit_leading_to_goal ||
        current_room.less_used_available_exits.detect {|exit| exit != current_room.visits_from.last}
    end

def see_through_next_exit_leading_to_goal
  current_room.available_exits.find {|exit|  self.send("room_#{exit}").position == goal_position}

end

    public
    def solve_maze
      reset_rooms_visits_from
        # binjjkding.pry

      until  current_position == goal_position  do
        puts "Current Room: Row: #{current_position.y}, Column: #{current_position.y}"
        # binding.pry if maze.rooms.count {|x| x.visited?} == 99
        # p path if maze.rooms.count {|x| x.visited?} == maze.rows * maze.columns
        # binding.pry
        if !available_exits_to_move_forward.empty? && best_move
          next_direction = best_move
          next_room = self.send "room_#{ next_direction}"

          current_room.used_exits << next_direction

          path << next_room.position ######################
          visited_positions << next_room.position
          next_room.visits_from << OPPOSITE_DIRECTION[ next_direction ]

          # build_room next_room, OPPOSITE_DIRECTION[ direction ]
        else
          binding.pry if current_room.unused_available_exits.empty?
          go_back_to_previous_visited_room
          path << current_room.position ######################
        end
        # sleep 1
      end
      puts "Solver Path:   #{ path.map{|p|[p.x,p.y]}.inspect}"
      puts  "Maze Solved after #{path.size} steps"
    end


  end
end
