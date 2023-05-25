require './lib/player'

RSpec.describe Player do
  describe '#make_move' do
    context "when player chooses a valid column index" do
      subject(:player) { described_class.new('Foo', Player::RED) }
      let(:valid_col_idx) { 0 }

      before do
        allow(player).to receive(:gets).and_return(valid_col_idx.to_s)
      end

      it "returns the column index" do
        expect(player.make_move).to eq(valid_col_idx)
      end
    end

    context "when player chooses an invalid column index" do
      subject(:player) { described_class.new('Foo', Player::BLUE) }
      let(:invalid_col_idx) { -1 }

      before do
        allow(player).to receive(:gets).and_return(invalid_col_idx.to_s)
      end

      it "raises the InvalidColumnIndex error" do
        expect{ player.make_move }.to raise_error(Player::InvalidColumnIndex)
      end
    end
  end
end
