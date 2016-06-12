# lib = File.expand_path('../lib', __FILE__)
require 'ruby2d'
require "thor"
require_relative "maze/version"
require_relative "maze/graphic"
require_relative "maze/room"
require_relative "maze/maze"
require_relative "maze/builder"
require_relative "maze/solver"


class MazeInit < Thor
  include Thor::Actions
  desc "hello NAME", "say hello to NAME"
  def build
    columns = ask('Please provide the maze width (number of columns):')
    rows = ask('Please provide the maze height (number of rows):')
    say('Maze is building ... ',:green)

    maze = Maze::Maze.new(rows: rows.to_i , columns: columns.to_i )  # no=>
    builder =Maze::Builder.new(maze: maze )
    builder.build_maze
    graphic = Maze::Graphic.new(maze: maze, builder: builder )
    graphic.draw_maze maze
  end
end

# MazeInit.start(ARGV)

module Maze
  # Your code goes here...
end
# (40,73)max
maze = Maze::Maze.new(rows: 30 , columns: 30 )  # no=>
# builder.build_maze
builder =Maze::Builder.new(maze: maze )
starting_position = Position.new( 1, 1)
goal_position = Position.new( 30, 30)

 solver = Maze::Solver.new(maze: maze, starting_position: starting_position, goal_position: goal_position)
builder.build_maze
solver.solve_maze

graphic = Maze::Graphic.new(maze: maze, builder: builder, solver: solver ) # binding.pry
# graphic = Maze::Graphic.new(maze: maze, builder: builder ) # binding.pry
graphic.draw_maze maze

# graphic.draw_builder_path
graphic.draw_solver_path
show
