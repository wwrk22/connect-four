require './lib/player'
require './lib/board'
require './lib/game'

puts "Play Connect Four"
print "Enter first player's name: "
p1_name = gets.chomp
print "Enter second player's name: "
p2_name = gets.chomp
puts "#{p1_name} will play red, and #{p2_name} will play blue."

red = Player.new(p1_name, Board::RED)
blue = Player.new(p2_name, Board::BLUE)

board = Board.new
game = Game.new(board)

puts "#{red.name} goes first"

until game.determine_winner.nil? == false || board.full? do
  red_col_idx = nil
  until red_col_idx.nil? == false do
    begin
      print "#{red.name}, choose a column index (0 to 6) to play a move: "
      red_col_idx = red.choose_column
      break
    rescue Player::InvalidColumnIndex
    end
  end

  board.drop_piece(red.marker, red_col_idx)
  board.update_display
  puts board.to_s
  puts "#{red.name}, played a move on column #{red_col_idx}"

  break if game.determine_winner.nil? == false || board.full?

  blue_col_idx = nil
  until blue_col_idx.nil? == false do
    begin
      print "#{blue.name}, choose a column index (0 to 6) to play a move: "
      blue_col_idx = blue.choose_column
      break
    rescue Player::InvalidColumnIndex
    end
  end

  board.drop_piece(blue.marker, blue_col_idx)
  board.update_display
  puts board.to_s
  puts "#{blue.name}, played a move on column #{blue_col_idx}"
end

puts
board.update_display
puts board.to_s
winner = game.determine_winner

if winner == red.marker
  puts "#{red.name} wins"
elsif winner == blue.marker
  puts "#{blue.name} wins"
else
  puts "Tie"
end
