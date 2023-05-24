class Board
  RED = 'R'
  BLUE = 'B'
  COLUMN_COUNT = 7
  COLUMN_SIZE = 6


  def initialize
    @columns = []
    @display = []
    COLUMN_COUNT.times { |_| @columns << [] }
    create_display
  end

  def drop_piece(color, column_index)
    raise BoardFullError if column_full? column_index
    @columns[column_index] << color
  end

  def column_full?(column_index)
    @columns[column_index].size == COLUMN_SIZE
  end

  def clear_board
    @columns.each { |column| column.clear }
  end

  def update_display
    @columns.each_with_index do |col, col_index|
      col.each_with_index do |slot, slot_index|
        display_row_index = (COLUMN_SIZE - 1) - slot_index
        @display[display_row_index][col_index] = slot
      end
    end
  end

  class BoardFullError < StandardError
    def message
      "Board is full."
    end
  end

  private

  def create_display
    6.times do
      empty_row = []
      7.times { empty_row << "\u25cb" }
      @display << empty_row
    end
  end
end
