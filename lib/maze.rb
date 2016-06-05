
# lib = File.expand_path('../lib', __FILE__)
require 'ruby2d'
require_relative "maze/version"
require_relative "maze/graphic"
require_relative "maze/room"
require_relative "maze/maze"


module Maze
  # Your code goes here...
end
maze = Maze::Maze.new(rows: 10, columns: 10)  # no=>
# binding.pry

# maze.find_room(3, 5)   # =>
graphic = Maze::Graphic.new(width: 1000 ,height:  1000, title: 'My shitty Maze')
graphic.draw_maze maze

# ~> LoadError
# ~> cannot load such file -- /tmp/seeing_is_believing_temp_dir20160605-31616-f8o41n/maze/version
# ~>
# ~> /tmp/seeing_is_believing_temp_dir20160605-31616-f8o41n/program.rb:4:in `require_relative'
# ~> /tmp/seeing_is_believing_temp_dir20160605-31616-f8o41n/program.rb:4:in `<main>'
