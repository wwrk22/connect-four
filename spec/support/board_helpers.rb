require './lib/board'

module BoardHelpers
  def create_test_display(row_index = nil,
                          col_index = nil,
                          marker = Board::EMPTY_SLOT)
    display = Board.create_display
    display[row_index][col_index] = marker if row_index && col_index
    return Board.display_to_s(display)
  end
end
