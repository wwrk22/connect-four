require './lib/board_setting'
require './lib/board'

class Game
  include BoardSetting

  DIRECTIONS = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]

  def initialize(board = Board.new)
    @board = board
  end

  def check_direction(x, y, direction, marker = @board.at(x, y))
    return nil unless position_inbounds?(x, y) && marker != Board::EMPTY_SLOT
    count = 0

    while position_inbounds?(x, y)  do
      return nil if @board.at(x, y) != marker
      x += direction[0]
      y += direction[1]
      count += 1
      break if count == 4
    end

    return marker if count == 4
    return nil
  end

  def determine_winner
    
  end

  private

  # The x refers to the index of a column in @columns of Board class, and y
  # refers to the index within a column.
  def position_inbounds?(x, y)
    (0 <= x && x < COLUMN_COUNT) && (0 <= y && y < COLUMN_SIZE)
  end
end
