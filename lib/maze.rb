

# lib = File.expand_path('../lib', __FILE__)
require 'ruby2d'
require_relative "maze/version"
require_relative "maze/graphic"
require_relative "maze/room"
require_relative "maze/maze"
require_relative "maze/builder"


module Maze
  # Your code goes here...
end
maze = Maze::Maze.new(rows: 10, columns: 10)  # no=>
# binding.pry

builder =Maze::Builder.new(maze: maze )
# binding.pry

builder.build_maze
# p maze

graphic = Maze::Graphic.new(width: 1000 ,height:  1000, title: 'My shitty Maze')
graphic.draw_maze maze

