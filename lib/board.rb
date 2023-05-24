class Board
  RED = 'R'
  BLUE = 'B'
  MAX_COLUMN_SIZE = 7

  def initialize
    @columns = Array.new(MAX_COLUMN_SIZE, Array.new())
  end

  def drop_piece(color, column_index)
    raise BoardFullError if column_full? column_index
    @columns[column_index] << color
  end

  def column_full?(column_index)
    @columns[column_index].size == MAX_COLUMN_SIZE
  end

  class BoardFullError < StandardError
    def message
      "Board is full."
    end
  end
end
