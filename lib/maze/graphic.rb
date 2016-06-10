# require "maze/version"
require 'ruby2d'
require 'pry'
require_relative "room"

module Maze
  class Graphic
    WALL_THICKNESS = 2
    ROOM_SIZE = 25
    ROOM_COLOR = 'black'
    WALL_COLOR = 'teal'
    BUILDER_COLOR = 'gray'
    attr_reader :width, :height, :title, :rooms
    attr_accessor :maze, :builder, :solver
     def initialize(options={})
      @maze = options[ :maze ]
      @builder = options[ :builder ]
      @solver = options[ :solver ]
      @title = 'Ruby Maze by Spiros Kabasakalis'
      @width =  maze.columns * ROOM_SIZE
      @height = maze.rows * ROOM_SIZE
      @rooms = maze.rooms

      set width: self.width, height: self.height, title: self.title, fps: 1
    end
    # def self.show
     #
    #   show
    # end

    def draw_maze(maze)
      maze.rooms.each do |room|
        draw_room( room, ROOM_SIZE)
        if self.builder
          draw_walls(room, WALL_COLOR)
        else
          draw_all_walls(room, WALL_COLOR)
        end
      end
      # show
    end

    def draw_builder_path
      builder.path.each do |position|
        update do
          _room = maze.find_room(position)
          draw_walls(_room, WALL_COLOR)
          draw_room(_room, ROOM_SIZE, BUILDER_COLOR )

        end
      end
    end
    def draw_room(room, size = ROOM_SIZE,color =  ROOM_COLOR)
      canvas_x = to_canvas_coordinate(room.x)
      canvas_y = to_canvas_coordinate(room.y)
      # binding.pry
      s = Square.new(canvas_x, canvas_y, size, color)    # Create a new square
    end

    def to_canvas_coordinate(coord)
      ( coord - 1 ) * ROOM_SIZE
    end

    def draw_all_walls(room, color)
      ['left', 'right', 'up', 'down'].each do |side|
        self.send :draw_wall,  room, side, color
      end
    end
    def draw_walls(room, color)
      ['left', 'right', 'up', 'down'].each do |side|
        # binding.pry
        if !room.available_exits.include?(side.to_sym)
          self.send :draw_wall,  room, side, color
        end
      end
    end


    def draw_wall(room ,side, color )
      canvas_x = to_canvas_coordinate(room.x)
      canvas_y = to_canvas_coordinate(room.y)
      case side
      when 'left'
        wall =  Quad.new(canvas_x, canvas_y ,
          canvas_x + WALL_THICKNESS,  canvas_y,
          canvas_x + WALL_THICKNESS, canvas_y + ROOM_SIZE,
        canvas_x , canvas_y + ROOM_SIZE,  color  )
      when 'right'
        wall =  Quad.new(canvas_x + ROOM_SIZE - WALL_THICKNESS, canvas_y ,
          canvas_x + ROOM_SIZE, canvas_y,
          canvas_x + ROOM_SIZE, canvas_y + ROOM_SIZE,
        canvas_x + ROOM_SIZE - WALL_THICKNESS , canvas_y + ROOM_SIZE,  color  )
      when 'up'
        wall =  Quad.new(canvas_x, canvas_y,
          canvas_x + ROOM_SIZE, canvas_y,
          canvas_x + ROOM_SIZE, canvas_y + WALL_THICKNESS,
        canvas_x , canvas_y + WALL_THICKNESS,  color  )
      when 'down'
        wall =  Quad.new(canvas_x, canvas_y + ROOM_SIZE - WALL_THICKNESS,
          canvas_x + ROOM_SIZE, canvas_y + ROOM_SIZE - WALL_THICKNESS,
          canvas_x + ROOM_SIZE, canvas_y + ROOM_SIZE,
        canvas_x , canvas_y + ROOM_SIZE,  color  )
      else
      end
      wall
    end
  end

end

