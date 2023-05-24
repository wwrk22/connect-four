class Board
  RED = "\e[31m\u25cf\e[0m"
  BLUE = "\e[34m\u25cf\e[0m"
  COLUMN_COUNT = 7
  COLUMN_SIZE = 6
  EMPTY_SLOT = "\u25cb"


  def initialize
    @columns = []
    COLUMN_COUNT.times { @columns << [] }
    @display = Board.create_display
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
        update_display_row(slot, slot_index, col_index)
      end
    end
  end

  def to_s
    Board.display_to_s(@display)
  end

  class BoardFullError < StandardError
    def message
      "Board is full."
    end
  end

  private

  def update_display_row(slot, slot_index, col_index)
    display_row_index = (COLUMN_SIZE - 1) - slot_index
    @display[display_row_index][col_index] = slot
  end

  class << self
    def create_display(display = [])
      COLUMN_SIZE.times { display << Board.create_display_row }
      return display
    end

    def create_display_row(empty_row = [])
      COLUMN_COUNT.times { empty_row << EMPTY_SLOT }
      return empty_row
    end

    def display_to_s(display)
      display.reduce("") do |str, row|
        str << row.join(" ")
        str << "\n"
      end
    end
  end
end
