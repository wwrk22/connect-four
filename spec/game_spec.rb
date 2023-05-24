require './lib/game'

RSpec.describe Game do
  describe '#check_direction' do
    context "when position is out-of-bounds" do
      subject(:game) { described_class.new }

      before do
        allow(game).to receive(:position_inbounds?).and_return(false)
      end

      it "returns nil" do
        result = game.check_direction(0, 0, [0, 1])
        expect(result).to be_nil
      end
    end

    context "when direction has four slots to check" do
      context "when all slots match" do
        let(:board) { instance_double(Board) }
        subject(:game) { described_class.new(board) }

        before do
          markers = [Board::RED, Board::RED, Board::RED, Board::RED]
          allow(board).to receive(:at).and_return(*markers)
        end

        it "returns the same color as the starting slot" do
          result = game.check_direction(0, 0, [0, 1], Board::RED)
          expect(result).to eq(Board::RED)
        end
      end

      context "when at least one slot does not match" do
        let(:board) { instance_double(Board) }
        subject(:game) { described_class.new(board) }

        before do
          markers = [Board::RED, Board::BLUE]
          allow(board).to receive(:at).and_return(*markers)
        end

        it "returns nil" do
          result = game.check_direction(0, 0, [0, 1], Board::RED)
          expect(result).to be_nil
        end
      end
    end

    context "when direction has less than four slots to check" do
      let(:board) { instance_double(Board) }
      subject(:game) { described_class.new(board) }

      before do
        allow(board).to receive(:at).and_return(Board::RED)
      end

      it "returns nil" do
        result = game.check_direction(0, 1, [0, -1], Board::RED)
        expect(result).to be_nil
      end
    end
  end # #check_direction

  describe '#determine_winner' do
    context "when there is no winner" do
      context "when the board is full" do
        subject(:game) { described_class.new }

        xit "returns nil" do
          winner = game.determine_winner
          expect(winner).to eq(Board::RED)
        end
      end

      context "when the board is not full" do
        subject(:game) { described_class.new }

      end
    end

    context "when there is a winner" do
      context "when the board is full" do
        subject(:game) { described_class.new }

      end

      context "when the board is not full" do
        subject(:game) { described_class.new }

      end
    end
  end
end
