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

    def times_used_to_exits
     available_exits.group_by do |exit|
       used_exits.count(exit)
     end
    end

    def less_used_available_exits
      times_used_to_exits[times_used_to_exits.keys.min]
    end

    def unused_available_exits
      times_used_to_exits[0] || []
    end

  end
end
