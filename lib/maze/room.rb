Position = Struct.new( :x, :y)
module Maze
  class Room
    attr_accessor :x, :y, :position, :visits_from, :available_exits, :used_exits
    EXITS = [:left, :up, :right, :down]
    def initialize(options)
      @x = options[:x]
      @y = options[:y]
      @visits_from = []
      @available_exits = []
      @used_exits = []
      @position = Position.new x, y
    end
    EXITS.each do |exit|
      define_method "#{exit}?" do
        return true if available_exits.include?(exit)
        return false
      end
    end
    def visited?
      !self.visits_from.empty?
    end
  end
end
