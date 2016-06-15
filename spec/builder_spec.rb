require 'spec_helper'
describe Maze::Builder  do
  before :all do
    @maze = Maze::Maze.new( rows: 10, columns: 10)
    @builder = Maze::Builder.new( maze: @maze )
  end
  context 'Initialized Builder' do
    [:maze, :path, :visited_positions].each do |method|
      it "should respond to #{method}" do
        expect( @builder ).to respond_to(method)
      end
    end
  end

  context 'Built Maze' do
    before :all do
      @builder.build_maze
    end
    it "should have all rooms visited by the builder" do
      expect( @builder.maze.rooms.all?{|room| !room.visits_from.empty? } ).to be true
    end

    it "should not have an empty builder path" do
      expect( @builder.path ).to_not eq( [] )
    end
  end

end
