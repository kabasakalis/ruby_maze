module Maze
  class Solver < Builder
    attr_reader  :maze, :path, :visited_positions, :starting_position, :goal_position

    def initialize(options)
      @maze = options[:maze]
      @starting_position = options[:starting_position]
      @goal_position = options[:goal_position]
      @path = [ @starting_position ]
      @visited_positions = @path.dup
    end

    private
    # Reset visits from builder.
    def reset_rooms_visits_from
      maze.rooms.each { |room| room.visits_from = []}
    end

    # The solver is assumed to be able to remember rooms he has visited,  what exits he used
    # and how many times each, and so chooses a random exit from the ones less used. If
    # no forward move is available, he goes back.
    def use_smart_strategy_to_choose_next_forward_move
      look_for_exit_leading_to_goal_in_next_room ||
      current_room.less_used_available_exits.detect {|exit| exit != current_room.visits_from.last}
    end

    # The solver is assumed to be able to look through available exits and see if the goal is there.
    # (Sees only one step ahead)
    def look_for_exit_leading_to_goal_in_next_room
      current_room.available_exits.find {|exit|  self.send("room_#{exit}").position == goal_position}
    end

    public
    def solve_maze
      puts "Maze is now being solved,please wait."
      reset_rooms_visits_from
      until  current_position == goal_position  do
        if  use_smart_strategy_to_choose_next_forward_move
          next_direction = use_smart_strategy_to_choose_next_forward_move
          next_room = self.send "room_#{ next_direction}"
          current_room.used_exits << next_direction
          path << next_room.position
          visited_positions << next_room.position
          next_room.visits_from << OPPOSITE_DIRECTION[ next_direction ]
        else #go back
          go_back_to_previous_visited_room
          path << current_room.position
        end
      end
      puts "Solver Path:   #{ path.map{|p|[p.x,p.y]}.inspect}"
      puts  "Maze Solved after #{path.size} steps"
    end

  end
end
