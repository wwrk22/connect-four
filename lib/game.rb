require './lib/board_setting'
require './lib/board'

class Game
  include BoardSetting

  def initialize(board = Board.new)
    @board = board
  end

  def check_all_directions(x, y)
    DIRECTIONS.each do |direction|
      result = check_direction(x, y, direction)
      return result if result
    end

    return nil
  end

  def check_direction(x, y, direction)
    marker = @board.at(x, y)
    return nil if marker == Board::EMPTY_SLOT
    count = check_slots(x, y, direction, marker)
    return (count == 4) ? marker : nil
  end

  def determine_winner
    0.upto(COLUMN_COUNT - 1) do |x|
      0.upto(COLUMN_SIZE - 1) do |y|
        result = check_all_directions(x, y)
        return result if result
      end
    end

    return nil
  end

  private
  
  def check_slots(x, y, direction, marker)
    count = 0

    while position_inbounds?(x, y)
      @board.at(x, y) == marker ? (count += 1) : (return nil)
      break if count == 4
      x, y = [x + direction[0], y + direction[1]]
    end

    return count
  end

  # The x refers to the index of a column in @columns of Board class, and y
  # refers to the index within a column.
  def position_inbounds?(x, y)
    (0 <= x && x < COLUMN_COUNT) && (0 <= y && y < COLUMN_SIZE)
  end
end
