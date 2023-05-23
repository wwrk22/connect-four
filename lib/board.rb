class Board
  RED = 'R'
  BLUE = 'B'

  def initialize
    @columns = Array.new(7, Array.new())
  end

  def drop_piece(color, column_index)
    if full?
      # TO-DO
      puts "RAISE CUSTOM ERROR HERE"
    else
      @columns[column_index] << color
    end
  end

  def full?
  end
end
