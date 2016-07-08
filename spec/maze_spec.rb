require 'spec_helper'
describe Maze do
  before :each do
    @maze = Maze::Maze.new(rows: 10, columns: 10)
  end

  it 'has a version number' do
    expect(Maze::VERSION).not_to be nil
  end

  context 'Initialized Maze' do
    [:rooms, :rows, :columns].each do |method|
      it "should respond to #{method}" do
        expect(@maze).to respond_to(method)
      end
    end

    it 'should have rows times columns rooms' do
      expect(@maze.rooms.count).to be @maze.columns * @maze.rows
    end
    it 'should have unvisited rooms' do
      expect(@maze.all_rooms_visited?).to be false
    end
    it 'should be able to find a room by position' do
      # Position = Struct.new( :x, :y)
      room_5_7 = @maze.find_room(Position.new(5, 7))
      expect(room_5_7.class).to equal Maze::Room
      expect(room_5_7.x).to be 5
      expect(room_5_7.y).to be 7
    end
  end
end
