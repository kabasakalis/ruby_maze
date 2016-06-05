class Room

  attr_accessor :x, :y, :times_visited, :current, :available_moves, :previous
  def initialize(options)
    @x = options[:x]
    @y = options[:y]
    @times_visited = options[:times_visited]
    @current = false
    @available_moves = []
  end
end
