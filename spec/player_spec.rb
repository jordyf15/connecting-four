require '../lib/player'

describe Player do
  describe "#drop_piece" do
    subject(:player) {described_class.new "player1", 1}
      context "Drop to a full column once" do
        before do
          allow(player).to receive(:gets).and_return('8', '1')
        end
        let(:cage) {[
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          ]}
          it "puts an error message" do
            expect(player).to receive(:puts).with("That column is already full. Please choose another one!")
            player.drop_piece(cage)
          end
      end

      context "The column is not full" do
        before do
          allow(player).to receive(:gets).and_return('8')
        end
        let(:cage) {[
          [nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          ]}
          it "does not puts an error message" do
            expect(player).not_to receive(:puts).with("That column is already full. Please choose another one!")
            player.drop_piece(cage)
          end
          it "return the piece and the cage column" do
            result = player.drop_piece(cage)
            expect(result).to eql({piece: 1, column: 7})
          end
      end

      context "Drop to an unexisting column once" do
        before do
          allow(player).to receive(:gets).and_return('10', '1')
        end
        let(:cage) {[
          [nil,nil,nil,nil,nil,nil,nil,nil],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          [nil,nil,nil,nil,nil,nil,nil,1],
          ]}
          it "puts an error message" do
            expect(player).to receive(:puts).with("Please choose a column between 1-8!")
            player.drop_piece cage
          end
      end
  end

end