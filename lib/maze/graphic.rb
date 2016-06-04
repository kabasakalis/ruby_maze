# require "maze/version"
require 'ruby2d'
require 'pry'
module Maze
  class Graphic
    WALL_THICKNESS = 3
    attr_accessor :width, :height, :title
    def initialize(options={})
      @title = options[:title]
      @width = options[:width]
      @height = options[:height]
      set width: self.width, height: self.height, title: self.title
    end
    def self.show
      show
    end

    def room(x, y, size, color)
      s = Square.new(x, y, size, color)    # Create a new square
    end

    def wall(room ,side, color )
      case side


        when 'left'

          # binding.pry
          wall =  Quad.new(room.x, room.y ,
                           room.x + WALL_THICKNESS,  room.y,
                           room.x + WALL_THICKNESS, room.y + room.size,
                           room.x , room.y + room.size,  color  )


        when 'right'
          wall =  Quad.new(room.x + room.size - WALL_THICKNESS, room.y ,
                           room.x + room.size, room.y,
                           room.x + room.size, room.y + room.size,
                           room.x + room.size - WALL_THICKNESS , room.y + room.size,  color  )
        else
        end
      wall
    end
  end

end

    # q = Quad.new(0,499,100,499,100,500,0,500)
    # show # => nil
