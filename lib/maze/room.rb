module Maze
  class Room
    attr_accessor :x, :y, :visits, :available_exits
    EXITS = [:left, :up, :right, :down]
    def initialize(options)
      @x = options[:x]
      @y = options[:y]
      @visits = []
      @available_exits = []
    end
    EXITS.each do |exit|
      define_method "#{exit}?" do
        return true if available_exits.include?(exit)
        return false
      end
    end
  end
end
