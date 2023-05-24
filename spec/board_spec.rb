require './lib/board.rb'
require './spec/support/board_helpers'

RSpec.configure do |cfg|
  cfg.include BoardHelpers
end

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '.new' do
    it "creates an array of seven empty arrays" do
      columns = board.instance_variable_get(:@columns)
      empty_board = Array.new
      Board::COLUMN_COUNT.times { |_| empty_board << Array.new }
      expect(columns).to eql(empty_board)
    end

    it "creates an array of six rows of empty circles" do
      display = board.instance_variable_get(:@display)
      empty_display = create_display
      puts "empty_display"
      expect(display).to eql(empty_display)
    end
  end

  describe '#drop_piece' do
    let(:column_index) { 0 }
    let(:row_index) { 0 }

    context "when the board is not full" do
      before do
        allow(board).to receive(:column_full?).with(column_index).and_return(false)
      end

      it "drops the given piece in the designated column" do
        board.drop_piece(Board::RED, column_index)
        column_zero = board.instance_variable_get(:@columns)[column_index]
        expect(column_zero[row_index]).to eq(Board::RED)
      end
    end

    context "when the board is full" do
      before do
        allow(board).to receive(:column_full?).with(column_index).and_return(true)
      end

      it "raises the BoardFullError" do
        expect { board.drop_piece(Board::RED, column_index) }.to raise_error(Board::BoardFullError)
      end
    end
  end

  describe '#column_full?' do
    let(:column_index) { 0 }

    context "when the column is full" do
      before do
        columns = board.instance_variable_get(:@columns)
        Board::COLUMN_SIZE.times { |_| columns[column_index] << Board::RED }
      end

      it "returns true" do
        result = board.column_full? column_index
        expect(result).to eq(true)
      end
    end

    context "when the column is not full" do
      it "returns false" do
        result = board.column_full? column_index
        expect(result).to eq(false)
      end
    end
  end

  describe '#clear_board' do
    matcher :have_empty_columns do
      match do |columns|
        columns.all? { |column| column.empty? }
      end
    end

    before do
      columns = board.instance_variable_get(:@columns)
      columns[0] << 'R'
    end

    it "clears all columns" do
      board.clear_board
      columns = board.instance_variable_get(:@columns)
      expect(columns).to have_empty_columns
    end
  end

  describe '#update_display' do
    context "when no new pieces have been dropped into any columns" do
      it "does not update the display" do
        # Create an empty display.
        empty_display = create_display

        # Update the display, then check.
        board.update_display
        display = board.instance_variable_get(:@display)
        expect(display).to eql(empty_display)
      end
    end

    context "when a new piece has been dropped into a column" do
      it "correctly reflects the change" do
        # Create a non-empty display that contains a single red piece at the
        # bottom left corner of the board.
        non_empty_display = create_display
        non_empty_display[5][0] = Board::RED

        # Make the columns of the board object reflect the same state.
        columns = board.instance_variable_get(:@columns)
        columns[0][0] = Board::RED

        # Update the display, then check.
        board.update_display
        display = board.instance_variable_get(:@display)
        expect(display).to eql(non_empty_display)
      end
    end
  end
end
