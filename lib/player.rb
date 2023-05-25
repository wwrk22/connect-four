require './lib/board_setting'

class Player
  include BoardSetting

  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def make_move
    col_idx = gets.chomp.to_i
    return col_idx if 0 <= col_idx && col_idx <= 6
    raise InvalidColumnIndex
  end

  class InvalidColumnIndex < StandardError
    def message
      "Invalid column index."
    end
  end
end
