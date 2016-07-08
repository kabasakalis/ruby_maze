require 'spec_helper'
describe Maze::Room do
  before :each do
    @room = Maze::Room.new x: 4, y: 13
  end
  context 'Initialized Room' do
    [:x, :y, :visits_from, :available_exits, :used_exits, :position].each do |method|
      it "should respond to #{method}" do
        expect(@room).to respond_to(method)
      end
    end
  end
  context 'Initialized Room should have values' do
    it 'x equal to 4' do
      expect(@room.x).to eql(4)
    end
    it 'y equal to 13' do
      expect(@room.y).to eql(13)
    end
    it 'visits_from array empty' do
      expect(@room.visits_from).to be_empty
    end
    it 'available_exits array empty' do
      expect(@room.available_exits).to be_empty
    end
    it 'used_exits array empty' do
      expect(@room.used_exits).to be_empty
    end
    it 'Has never been visited' do
      expect(@room.visits_from).to be_empty
    end
  end
  context 'Exit is available to ' do
    before :each do
      @room.available_exits = [:left, :up]
    end
    it 'left? Yes.' do
      expect(@room.left?).to be true
    end
    it 'right? No.' do
      expect(@room.right?).to be false
    end
    it 'up? Yes.' do
      expect(@room.up?).to be true
    end
    it 'down? No.' do
      expect(@room.down?).to be false
    end
  end

  context 'visited?' do
    it 'unvisited' do
      @room.visits_from = []
      expect(@room.visited?).to be false
    end
    it 'visited' do
      @room.visits_from = [:left, :right]
      expect(@room.visited?).to be true
    end
  end
  context 'Keep statistics' do
    before :each do
      @room.available_exits = [:left, :up, :down]
      @room.used_exits = [:left, :up, :up, :left, :up, :left, :left, :down]
    end
    it 'times_used_to_exits' do
      expect(@room.times_used_to_exits[1]).to eq([:down])
      expect(@room.times_used_to_exits[4]).to eq([:left])
      expect(@room.times_used_to_exits[3]).to eq([:up])
    end
    it 'less_used_available_exits' do
      expect(@room.less_used_available_exits).to eq([:down])
    end
    it 'unused_available_exits' do
      expect(@room.unused_available_exits).to eq([])
    end
  end
end
