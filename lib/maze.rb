
# lib = File.expand_path('../lib', __FILE__)
require 'ruby2d'
require_relative "maze/version"
require_relative "maze/graphic"

module Maze
  # Your code goes here...
  def build
    graphic = Maze::Graphic.new(width: 700 ,height:  500, title: 'My shitty Maze')
    room = graphic.room(0, 0, 200, 'blue')
    room2 = graphic.room(0, 200,  200, 'blue')
    left_wall = graphic.wall(room, 'left', 'red')
    right_wall = graphic.wall(room, 'right', 'green')
    left_wall2 = graphic.wall(room2, 'left', 'red')
    right_wall2 = graphic.wall(room2, 'right', 'green')
    right_wall2_undo = graphic.wall(room2, 'right', 'blue')
   graphic.show
  end
  module_function :build
end
Maze.build # =>

# ~> LoadError
# ~> cannot load such file -- /tmp/seeing_is_believing_temp_dir20160605-16074-qg99nw/maze/version
# ~>
# ~> /tmp/seeing_is_believing_temp_dir20160605-16074-qg99nw/program.rb:4:in `require_relative'
# ~> /tmp/seeing_is_believing_temp_dir20160605-16074-qg99nw/program.rb:4:in `<main>'
