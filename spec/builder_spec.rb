require 'maze/builder'
require 'maze/room'
describe Maze::Builder  do
  before :each do
    @maze = Maze::Maze.new( rows: 10, columns: 10)
    @builder = Maze::Builder.new( maze: @maze )
  end
  context 'Initialized Builder' do
    [:maze, :current_position, :previous_position
].each do |method|
      it "should respond to #{method}" do
        expect( @builder ).to respond_to(method)
      end
    end

    it "should have a non nil random current_position " do
      expect( @builder.current_position ).not_to be nil
    end
    it "should have an initial current room." do
      expect( @builder.current_room.class ).to equal Maze::Room
      expect( @builder.current_room.x ).to be @builder.current_position.x
      expect( @builder.current_room.y ).to be @builder.current_position.y
    end
  end

end
