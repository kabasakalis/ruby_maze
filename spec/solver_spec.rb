require 'spec_helper'

describe Maze::Solver do
  before :all do
    @maze = Maze::Maze.new(rows: 10, columns: 10)
    @builder = Maze::Builder.new(maze: @maze)
    @starting_position = Position.new(2, 3)
    @goal_position = Position.new(8, 9)
    @solver = Maze::Solver.new(maze: @maze, starting_position:    @starting_position, goal_position: @goal_position)
    @builder.build_maze
  end
  context 'Initialized solver' do
    [:maze, :starting_position, :goal_position, :path, :visited_positions].each do |method|
      it "should respond to #{method}" do
        expect(@solver).to respond_to(method)
      end
    end
  end

  context 'Solved Maze' do
    before :all do
      @solver.solve_maze
    end

    it 'should not have an empty solver path' do
      expect(@solver.path).to_not eq([])
    end

    it 'Goal has been reached!' do
      expect(@goal_position).to eql(@solver.path.last)
    end
  end
end
