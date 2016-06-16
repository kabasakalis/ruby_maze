$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ruby2d'
require 'thor'
require 'logger'
require 'pry'

module Maze
  OPPOSITE_DIRECTION = { left: :right, up: :down, right: :left, down: :up }.freeze

  DIRECTIONS = OPPOSITE_DIRECTION.keys
  ROWS_MIN = 1
  ROWS_MAX = 40
  COLUMNS_MIN = 1
  COLUMNS_MAX = 73
  CANVAS_SLEEP_MAX = 1.0

  module Log
    def log
      if @logger.nil?
        @logger = Logger.new STDOUT
        @logger.level = Logger::INFO
        @logger.datetime_format = '%Y-%m-%d %H:%M:%S '
      end
      @logger
    end
  end
end

require_relative 'maze/version'
require_relative 'maze/canvas'
require_relative 'maze/room'
require_relative 'maze/maze'
require_relative 'maze/builder'
require_relative 'maze/solver'
require_relative 'helpers/thor.rb'

class MazeInit < Thor
  include Thor::Actions

  desc 'maze build', "Just build a maze, but don't solve it."
  def build
    title
    rows, columns = ask_for_maze_dimensions
    sleep = ask_for_sleep_interval
    maze = Maze::Maze.new(rows: rows.to_i, columns: columns.to_i) # no=>
    builder = Maze::Builder.new(maze: maze)
    canvas = Maze::Canvas.new(maze: maze, builder: builder, sleep: sleep)
    canvas.draw_maze maze
    builder.build_maze
    canvas.draw_builder_path
    show
  end

  desc 'maze solve', 'Build and solve a maze'
  def solve
    title
    rows, columns = ask_for_maze_dimensions
    sleep = ask_for_sleep_interval
    starting_position, goal_position = ask_for_start_and_goal(rows, columns)
    maze = Maze::Maze.new(rows: rows.to_i, columns: columns.to_i)
    builder = Maze::Builder.new(maze: maze)
    solver = Maze::Solver.new(maze: maze, starting_position:    starting_position, goal_position: goal_position)
    builder.build_maze
    solver.solve_maze
    canvas = Maze::Canvas.new(maze: maze, builder: builder, solver: solver, sleep: sleep)
    canvas.draw_maze maze
    canvas.draw_solver_path
    show
  end

  no_commands do
    def title
      say_status('Ruby Maze', 'by Spiros Kabasakalis.', :green)
    end

    def ask_for_maze_dimensions
      columns = ask_with_tag('Please provide the maze width (number of columns):',
        "Columns (1 to #{Maze::COLUMNS_MAX})")
      until (1..Maze::COLUMNS_MAX).member?(columns.to_i)
        say_status('Invalid input', "Columns must be between 1 and #{Maze::COLUMNS_MAX}", :red)
        columns = ask_with_tag('Please provide the maze width (number of columns):',
          "Columns (1 to #{Maze::COLUMNS_MAX})")
      end
      rows = ask_with_tag('Please provide the maze width (number of rows):', "Rows (1 to #{Maze::ROWS_MAX})")
      until (1..Maze::ROWS_MAX).member?(rows.to_i)
        say_status('Invalid input', "Rows must be between 1 and #{Maze::ROWS_MAX}", :red)
        rows = ask_with_tag('Please provide the maze height (number of rows):', "Rows (1 to #{Maze::ROWS_MAX})")
      end
      [rows, columns]
    end

    def ask_for_sleep_interval
      sleep = ask_with_tag('Please provide animation speed, 0.0 to 1.0 sec. Use values greater than 0
                           for smaller mazes. Return or invalid entry will accept the default of zero delay
                           (fastest).', "Sleep (0.0 to #{Maze::CANVAS_SLEEP_MAX})")
      until sleep.to_f >= 0.0 && sleep.to_f <= Maze::CANVAS_SLEEP_MAX
        say_status('Invalid input', "Animation delay (speed) must be between 0 and #{Maze::CANVAS_SLEEP_MAX}", :red)
        sleep = ask_with_tag('Please provide animation speed, 0.0 to 1.0 sec. Use values greater than 0 for smaller
                              mazes. Return or invalid entry will accept the default of zero delay (fastest).',
          "Sleep (0.0 to #{Maze::CANVAS_SLEEP_MAX})")
      end
    end

    def ask_for_start_and_goal(rows, columns)
      start = lambda do
        ask_with_tag('Please provide the STARTING  point comma separated coordinates x(column number), y(row number).
                          For example: 18,10', "x: #{Maze::COLUMNS_MIN} to #{columns}, y: #{Maze::ROWS_MIN} to #{rows}")
      end
      goal = lambda do
        ask_with_tag('Please provide the GOAL point comma separated coordinates x(column number), y(row number).
                           For example: 18,10', "x: #{Maze::COLUMNS_MIN} to #{columns}, y: #{Maze::ROWS_MIN} to #{rows}")
      end
      compute_position = lambda do |point|
        coords = point.call.split(',').map(&:to_i)
        x, y = coords
        Position.new(x, y)
      end

      starting_position = compute_position.call start
      until (Maze::COLUMNS_MIN..columns.to_i).member?(starting_position.x) && (Maze::ROWS_MIN..rows.to_i).member?(starting_position.y)
        say_status('Invalid input', "x: #{Maze::COLUMNS_MIN} to #{columns}, y: #{Maze::ROWS_MIN} to #{rows}", :red)
        starting_position = compute_position.call start
      end

      goal_position = compute_position.call goal
      until (Maze::COLUMNS_MIN..columns.to_i).member?(goal_position.x) && (Maze::ROWS_MIN..rows.to_i).member?(goal_position.y) && goal_position != starting_position
        say_status('Invalid input', "x: #{Maze::COLUMNS_MIN} to #{columns}, y: #{Maze::ROWS_MIN} to #{rows}", :red)
        say_status('GOAL MUST BE DIFFERENT THAN START', "OK, your zen is cute, but let's make this a little interesting!", :red) if goal_position == starting_position
        goal_position = compute_position.call goal
      end
      [starting_position, goal_position]
    end
  end
end

MazeInit.start(ARGV)
