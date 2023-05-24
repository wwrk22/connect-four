require_relative '../lib/board.rb'

RSpec.describe Board do
  subject(:board) { described_class.new }

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
end
