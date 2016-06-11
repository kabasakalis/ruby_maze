

# lib = File.expand_path('../lib', __FILE__)
require 'ruby2d'
require "thor"
require_relative "maze/version"
require_relative "maze/graphic"
require_relative "maze/room"
require_relative "maze/maze"
require_relative "maze/builder"

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
maze = Maze::Maze.new(rows: 10 , columns: 10  )  # no=>
# builder.build_maze
builder =Maze::Builder.new(maze: maze )
graphic = Maze::Graphic.new(maze: maze, builder: builder )
graphic.draw_maze maze
# show    # INITIALIZED MAZE
# graphic.draw_builder_path

    # builder.build_maze_like_a_robot
builder.build_maze
update do
  # position = Position.new(rand(1..maze.rows),rand(1..maze.columns))
  # room = maze.find_room(position)
  # graphic.draw_room(room, 25, 'red')

  position= builder.path.shift
  # pindex=builder.path.index {|p|p.x == position.x && p.y == position.y }
  if position
  _room = maze.find_room(position)
  graphic.draw_room(_room, Maze::Graphic::ROOM_SIZE,Maze::Graphic:: BUILDER_COLOR )
  graphic.draw_walls(_room,Maze::Graphic::WALL_COLOR)
  # p=Text.new((position.x-1)*Maze::Graphic::ROOM_SIZE,(position.y-1)*Maze::Graphic::ROOM_SIZE,10,[position.x,position.y].join(',')  ,  'DroidSans','red')
  p=Text.new((position.x-1)*Maze::Graphic::ROOM_SIZE+10,(position.y-1)*Maze::Graphic::ROOM_SIZE+10,10,builder.path.size.to_s,  'DroidSans','red')
  end
  sleep 0.5
  # p=Text.new(position.x,position.y,10,'   ',  'DroidSans','black')
end
show
graphic.draw_maze maze
show
# p path if maze.rooms.count {|x| x.visited?} == maze.rows * maze.columns
