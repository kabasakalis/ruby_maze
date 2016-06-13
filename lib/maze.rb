require 'ruby2d'
require "thor"
require "ruby-progressbar"

module Maze

  OPPOSITE_DIRECTION = { left: :right, up: :down, right: :left, down: :up}
  DIRECTIONS = OPPOSITE_DIRECTION.keys
  ROWS_MAX = 40
  COLUMNS_MAX = 73
  CANVAS_SLEEP_MAX = 1.0
end

require_relative "maze/version"
require_relative "maze/canvas"

require_relative "maze/room"
require_relative "maze/maze"
require_relative "maze/builder"
require_relative "maze/solver"
require_relative "helpers/thor.rb"


class MazeInit < Thor
  include Thor::Actions

  desc "hello NAME", "say hello to NAME"
  def build
    say_status('Ruby Maze', 'by Spiros Kabasakalis.', :green)
    columns = ask_with_tag('Please provide the maze width (number of columns):',
                           "Columns (1 to #{Maze::COLUMNS_MAX})")
    while !(1..Maze::COLUMNS_MAX).member?( columns.to_i ) do
      say_status('Invalid input', "Columns must be between 1 and #{Maze::COLUMNS_MAX}", :red)
      columns = ask_with_tag('Please provide the maze width (number of columns):',
                             "Columns (1 to #{Maze::COLUMNS_MAX})")
    end
    rows = ask_with_tag('Please provide the maze width (number of rows):', "Rows (1 to #{Maze::ROWS_MAX})")
    while !(1..Maze::ROWS_MAX).member?( rows.to_i ) do
      say_status('Invalid input', "Rows must be between 1 and #{Maze::ROWS_MAX}", :red)
      rows = ask_with_tag('Please provide the maze height (number of rows):', "Rows (1 to #{Maze::ROWS_MAX})")
    end
    sleep = ask_with_tag('Please provide animation speed, 0.0 to 1.0 sec. Use values greater than 0 for smaller mazes. Return or invalid entry will accept the default of zero delay (fastest).', "Sleep (0.0 to #{Maze::CANVAS_SLEEP_MAX})")
    while !( sleep.to_f >= 0.0 && sleep.to_f <= Maze::CANVAS_SLEEP_MAX)  do
      say_status('Invalid input', "Animation delay (speed) must be between 0 and #{Maze::CANVAS_SLEEP_MAX}", :red)
      sleep  = ask_with_tag('Please provide animation speed, 0.0 to 1.0 sec. Use values greater than 0 for smaller mazes. Return or invalid entry will accept the default of zero delay (fastest).', "Sleep (0.0 to #{Maze::CANVAS_SLEEP_MAX})")
    end

# return
# (40,73)max
    maze = Maze::Maze.new(rows: rows.to_i , columns: columns.to_i )  # no=>
# builder.build_maze
builder =Maze::Builder.new(maze: maze )
starting_position = Position.new( 1, 1)
goal_position = Position.new( 10, 10)

solver = Maze::Solver.new(maze: maze, starting_position: starting_position, goal_position: goal_position)
builder.build_maze
solver.solve_maze

canvas = Maze::Canvas.new(maze: maze, builder: builder, solver: solver, sleep: sleep ) # binding.pry
# canvas = Maze::canvas.new(maze: maze, builder: builder ) # binding.pry
canvas.draw_maze maze

# canvas.draw_builder_path
canvas.draw_solver_path
show

    # builder =Maze::Builder.new(maze: maze )
    # builder.build_maze
    # canvas = Maze::Canvas.new(maze: maze, builder: builder )
    # canvas.draw_maze maze
  end
end

  # @middleman_folder = ask_with_tag('What is the name of the middleman folder?Usually it\'s middleman or frontend.','middleman')
  # while !File.exists?("#{@middleman_folder}") do
  # @middleman_folder = ask_with_tag('Middleman folder not found.Make sure there is a middleman folder in the root of your project (named middleman of frontend usually),and type the name.','middleman')
  # end
 MazeInit.start(ARGV)
# # return
# # (40,73)max
# maze = Maze::Maze.new(rows: 30 , columns: 30 )  # no=>
# # builder.build_maze
# builder =Maze::Builder.new(maze: maze )
# starting_position = Position.new( 1, 1)
# goal_position = Position.new( 30, 30)
#
# solver = Maze::Solver.new(maze: maze, starting_position: starting_position, goal_position: goal_position)
# builder.build_maze
# solver.solve_maze
#
# canvas = Maze::Canvas.new(maze: maze, builder: builder, solver: solver ) # binding.pry
# # canvas = Maze::canvas.new(maze: maze, builder: builder ) # binding.pry
# canvas.draw_maze maze
#
# # canvas.draw_builder_path
# canvas.draw_solver_path
# show
