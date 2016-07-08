require 'logger'
module Maze
  OPPOSITE_DIRECTION = { left: :right, up: :down, right: :left, down: :up }.freeze

  DIRECTIONS = OPPOSITE_DIRECTION.keys
  ROWS_MIN = 1
  ROWS_MAX = 40
  COLUMNS_MIN = 1
  COLUMNS_MAX = 73
  CANVAS_SLEEP_MAX = 1.0

  module Log
    def log
      if @logger.nil?
        @logger = Logger.new STDOUT
        @logger.level = Logger::INFO
        @logger.datetime_format = '%Y-%m-%d %H:%M:%S '
      end
      @logger
    end
  end
end
