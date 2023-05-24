require_relative '../lib/board.rb'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '.new' do
    it "creates an array of seven empty arrays" do
      columns = board.instance_variable_get(:@columns)
      empty_board = Array.new
      Board::COLUMN_COUNT.times { |_| empty_board << Array.new }
      expect(columns).to eql(empty_board)
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
end
