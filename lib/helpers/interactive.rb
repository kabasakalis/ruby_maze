module Maze
  class Questions < Thor

  include Thor::Actions

    def self.ask_start_and_goal
say_status('', 'Provide start and goal positions', :green)
 start =lambda{ ask_with_tag('Please provide the STARTING  point comma separated coordinates x(column number), y(row number).
                             For example: 18,10', "x: #{Maze::COLUMNS_MIN} to #{columns}) , y: #{Maze::ROWS_MIN} to #{rows}")}
 goal =lambda{ ask_with_tag('Please provide the GOAL point comma separated coordinates x(column number), y(row number).
                             For example: 18,10', "x: #{Maze::COLUMNS_MIN} to #{columns}) , y: #{Maze::ROWS_MIN} to #{rows}")}
compute_position = lambda do |point|
   _coords = point.call.split(',').map(&:to_i)
   x, y = _coords
   Position.new(x, y)
 end
 starting_position = compute_position.call start
 until ( Maze::COLUMNS_MIN..columns.to_i ).member?(starting_position.x) &&  ( Maze::ROWS_MIN..rows.to_i ).member?(starting_position.y) do
  say_status('Invalid input', "x: #{Maze::COLUMNS_MIN} to #{columns}, y: #{Maze::ROWS_MIN} to #{rows}", :red)
  starting_position= compute_position.call start
 end
 goal_position = compute_position.call goal
 until ( Maze::COLUMNS_MIN..columns.to_i ).member?(goal_position.x) &&
       ( Maze::ROWS_MIN..rows.to_i ).member?(goal_position.y) &&
       goal_position != starting_position do
  say_status('Invalid input', "x: #{Maze::COLUMNS_MIN} to #{columns}, y: #{Maze::ROWS_MIN} to #{rows}", :red)
  say_status('GOAL MUST BE DIFFERENT THAN START', "OK, your zen is cute :P, but let's make this little interesting!", :red) if goal_position == starting_position
  goal_position= compute_position.call goal

 end
 end
 end
  end
 Maze::Questions.start(ARGV)
