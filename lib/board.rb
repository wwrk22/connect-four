class Board
  RED = 'R'
  BLUE = 'B'

  def initialize
    @columns = Array.new(7, Array.new())
  end

  def drop_piece(color, column_index)
    raise BoardFullError if full?
    @columns[column_index] << color
  end

  def full?
  end

  class BoardFullError < StandardError
    def message
      "Board is full."
    end
  end
end
