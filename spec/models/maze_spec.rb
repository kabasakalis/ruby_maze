require 'maze/maze'
require 'maze/room'
describe Maze::Maze  do
  before :each do
    @maze = Maze::Maze.new rows: 10, columns: 10
  end

  context 'Initialized Maze' do
    [:rooms, :rows, :columns, :find_room].each do |method|
      it "should respond to #{method}" do
        expect( @maze ).to respond_to(method)
      end
    end
    it "should have 100 rooms" do
      expect( @maze.rooms.length ).to eql(100)
    end
  end
  context 'Public Method' do
    it "find_room(4,7) should return a room with x=4 and y=7" do
      room = @maze.find_room(4,7)
      expect(room.x).to eql(4)
      expect(room.y).to eql(7)

    end
  end





end
