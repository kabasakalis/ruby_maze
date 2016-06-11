
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
    current_room.available_exits - current_room.visits_from.last
  end


  def remember_less_used_exits_and_pick_one_of_them
    ( current_room.less_used_available_exits - current_room.visits_from.last).first
  end


  public
  def solve_maze
    while current_position != @goal_position  do
      # puts [current_position.x,current_position.y].inspect
      # puts path.map{|p|[p.x,p.y]}.inspect
      # binding.pry if maze.rooms.count {|x| x.visited?} == 99
      # p path if maze.rooms.count {|x| x.visited?} == maze.rows * maze.columns
      # binding.pry
      if !available_exits_to_move_forward.empty?
        next_direction = remember_less_used_exits_and_pick_one_of_them
        next_room = room next_direction

        current_room.used_exits << next_direction

        path << next_room.position ######################
        visited_positions << next_room.position
        next_room.visits_from << OPPOSITE_DIRECTION[direction]

        # build_room next_room, OPPOSITE_DIRECTION[ direction ]
      else
        go_back_to_previous_visited_room
        path << current_room.position ######################
      end
      sleep 2
    end
  end


end
end
