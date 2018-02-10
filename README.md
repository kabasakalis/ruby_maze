[![Build Status](https://travis-ci.org/drumaddict/ruby-maze.svg?branch=master&a=1)](https://travis-ci.org/kabasakalis/ruby-maze)
[![Code Climate](https://codeclimate.com/github/drumaddict/ruby-maze/badges/gpa.svg)](https://codeclimate.com/github/drumaddict/ruby-maze)
[![Test Coverage](https://codeclimate.com/github/drumaddict/ruby-maze/badges/coverage.svg)](https://codeclimate.com/github/drumaddict/ruby-maze/coverage)
# Ruby Maze
----
### Overview
 Building and solving a maze is a popular code challenge in almost every programming language.
 This is my take.
###### A 73 x 40 Maze being solved

![screenshot](https://github.com/drumaddict/ruby-maze/blob/master/assets/maze.png)

## Prerequisites
### [Ruby 2D gem](http://www.ruby2d.com/)
Simple 2D applications with Ruby. The gem is already a gemspec dependency, just run `bundle install`
### [Simple 2D](https://github.com/simple2d/simple2d)
You will need only one system dependency: a graphics and media library called Simple 2D.
* On OS X, the Ruby 2D gem will use Homebrew to install this library. You don't have to use Homebrew, but it makes things much simpler. Check out the [simple2d.rb formula](https://github.com/simple2d/homebrew-tap/blob/master/simple2d.rb) to see exactly what gets installed.
* On Linux, at the root of the project run `simple2d install`
or follow [these](https://github.com/simple2d/simple2d#welcome-to-simple-2d) instructions.

## Usage


First, make sure Simple 2D is installed in your system, then install the required gem dependencies with `bundle install`
* To build a maze (without solving it), run in the root of the project:  `ruby 'lib/maze_init.rb'  build`
* To build  and solve a maze, run in the root of the project:  `ruby 'lib/maze_init.rb' solve`

In both cases you will be asked for parameters (maze dimensions, animation speed, start and goal positions)
## License


The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

