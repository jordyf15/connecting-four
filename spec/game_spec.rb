require '../lib/game'

describe Game do
  describe "#play" do
    subject(:game) {described_class.new}
    context "the game is over" do
      before do 
        allow(game).to receive(:game_over?).and_return true
      end
      it "should call the game_result method" do
        expect(game).to receive(:game_result)
        game.play
      end
    end
  end

  describe "#play_again" do
    subject(:game) {described_class.new}
    context "user input y" do
      before do
        allow(game).to receive(:gets).and_return 'y'
      end
      it "should return true" do
        result = game.play_again?
        expect(result).to eql true
      end
    end

    context "user input n" do
      before do
        allow(game).to receive(:gets).and_return 'n'
      end
      it "should return false" do
        result = game.play_again?
        expect(result).to eql false
      end
    end
  end
end