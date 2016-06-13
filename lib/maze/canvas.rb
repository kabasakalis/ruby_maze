# require "maze/version"
require 'ruby2d'

require 'pry'
require_relative "room"

module Maze
  class Canvas

    COLORS = [ 'black', 'gray', 'silver', 'white', 'navy', 'blue', 'aqua', 'teal',
      'olive', 'green', 'lime', 'yellow', 'orange', 'red', 'maroon', 'fuchsia',
    'purple', 'brown', 'random' ]
    WALL_THICKNESS = 2
    ROOM_SIZE = 25
    ROOM_COLOR = 'black'
    WALL_COLOR = 'teal'
    BUILDER_COLOR = 'black'
    CURRENT_ROOM_POINTER_COLOR = 'yellow'
    CURRENT_ROOM_POINTER_SIZE = 6

    attr_reader :width, :height, :title, :rooms, :sleep
    attr_accessor :maze, :builder, :solver

    def initialize( options={} )
      @maze = options[ :maze ]
      @builder = options[ :builder ]
      @solver = options[ :solver ]
      @title = 'Ruby Maze by Spiros Kabasakalis'
      @width =  maze.columns * ROOM_SIZE
      @height = maze.rows * ROOM_SIZE
      @rooms = maze.rooms
      @sleep =options[ :sleep ].to_f

      set width: self.width, height: self.height, title: self.title
    end

    def to_canvas_coordinate(coord)
      ( coord - 1 ) * ROOM_SIZE
    end

    def draw_maze( maze )
      maze.rooms.each do |room|
        draw_room( room, ROOM_SIZE)
        if self.builder
          draw_walls(room, WALL_COLOR)
        else
          draw_all_walls(room, WALL_COLOR)
        end
      end
    end


    def draw_builder_path
      visited_positions = []
      update do
        previous_position = visited_positions.last
        visited_positions << position = builder.path.shift
        if position
          _room = maze.find_room( position )
          draw_room( _room, ROOM_SIZE, BUILDER_COLOR )
          draw_walls( _room, WALL_COLOR )
          draw_position _room
          _previous_room = maze.find_room( previous_position )
          draw_position( _previous_room, BUILDER_COLOR ) if _previous_room
        end
      end
        ::Kernel.sleep( @sleep || 0.0 )
    end


    def draw_solver_path
      visited_positions = []
      color_room( solver.starting_position, ROOM_SIZE, 'red')
      color_room( solver.goal_position, ROOM_SIZE, 'blue')
      update do
        previous_position = visited_positions.last
        visited_positions << position = solver.path.shift
        if position
          _room = maze.find_room( position )
          draw_position _room
          _previous_room = maze.find_room( previous_position )
          draw_position( _previous_room,CURRENT_ROOM_POINTER_SIZE ,'olive' ) if _previous_room
        end
        ::Kernel.sleep( @sleep || 0.0 )
      end
    end

    def draw_position( room, position_size = CURRENT_ROOM_POINTER_SIZE,  color = CURRENT_ROOM_POINTER_COLOR )
      pointer_x = to_canvas_coordinate(room.x)
      pointer_y = to_canvas_coordinate(room.y)
      pointer = Square.new(pointer_x + ROOM_SIZE/2 -  position_size/2,
                           pointer_y + ROOM_SIZE/2 - position_size/2,
                           position_size, color)
    end

    def draw_room( room, size = ROOM_SIZE,color = ROOM_COLOR )
      canvas_x = to_canvas_coordinate(room.x )
      canvas_y = to_canvas_coordinate(room.y )
      s = Square.new(canvas_x, canvas_y, size, color )
    end

    def color_room( room, size = ROOM_SIZE,color = ROOM_COLOR)
      canvas_x = to_canvas_coordinate(room.x)
      canvas_y = to_canvas_coordinate(room.y)
      s = Square.new( canvas_x, canvas_y, size, color )
    end

    def draw_all_walls( room, color )
      DIRECTIONS.each do |side|
        self.send :draw_wall,  room, side, color
      end
    end

    def draw_walls( room, color )
      DIRECTIONS.each do |side|
        if !room.available_exits.include?( side.to_sym )
          self.send :draw_wall,  room, side, color
        end
      end
    end

    def draw_wall( room ,side, color )
      canvas_x = to_canvas_coordinate( room.x )
      canvas_y = to_canvas_coordinate( room.y )
      case side
      when :left
        wall =  Quad.new( canvas_x, canvas_y ,
          canvas_x + WALL_THICKNESS,  canvas_y,
          canvas_x + WALL_THICKNESS, canvas_y + ROOM_SIZE,
        canvas_x , canvas_y + ROOM_SIZE,  color  )
      when :right
        wall =  Quad.new( canvas_x + ROOM_SIZE - WALL_THICKNESS, canvas_y ,
          canvas_x + ROOM_SIZE, canvas_y,
          canvas_x + ROOM_SIZE, canvas_y + ROOM_SIZE,
        canvas_x + ROOM_SIZE - WALL_THICKNESS , canvas_y + ROOM_SIZE,  color  )
      when :up
        wall =  Quad.new( canvas_x, canvas_y,
          canvas_x + ROOM_SIZE, canvas_y,
          canvas_x + ROOM_SIZE, canvas_y + WALL_THICKNESS,
        canvas_x , canvas_y + WALL_THICKNESS,  color  )
      when :down
        wall =  Quad.new( canvas_x, canvas_y + ROOM_SIZE - WALL_THICKNESS,
          canvas_x + ROOM_SIZE, canvas_y + ROOM_SIZE - WALL_THICKNESS,
          canvas_x + ROOM_SIZE, canvas_y + ROOM_SIZE,
        canvas_x , canvas_y + ROOM_SIZE,  color  )
      else
      end
      wall
    end
  end

end

