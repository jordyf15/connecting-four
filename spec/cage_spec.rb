require '../lib/cage'

describe Cage do
  describe "#insert_piece" do
    subject(:cage){described_class.new}
    let(:player_number) {1}
    before do
      cage.instance_variable_set(:@columns, [
        [nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,1],
        [nil,nil,nil,nil,nil,nil,nil,1],
        [nil,nil,nil,nil,nil,nil,nil,1],
        [nil,nil,nil,nil,nil,nil,nil,1],
      ])
    end

    context "insert a piece to an empty column" do
      it "should fill the most bottom one" do
        chosen_column = 0
        cage.insert_piece(player_number, chosen_column)
        result = cage.instance_variable_get(:@columns)[7][chosen_column]
        expect(result).to eql 1
      end
    end

    context "insert a piece to an already filled but not full column" do
      it "should fill the most empty bottom one in that column" do
        chosen_column = 7
        cage.insert_piece(player_number, chosen_column)
        result = cage.instance_variable_get(:@columns)[3][chosen_column]
        expect(result).to eql 1
      end
    end
  end

  describe "#check_cage?" do
    subject(:cage) {described_class.new}
    context "player manage to create a horizontal row" do
      before do
        cage.instance_variable_set(:@columns, [
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, 1, 1, 1, 1, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
        ])
      end
      it "should return win" do
        result = cage.check_game_over
        expect(result).to eql 'win'
      end
    end

    context "player manage to create a vertical row" do
      before do
        cage.instance_variable_set(:@columns, [
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [1, nil, nil, nil, nil, nil, nil, nil],
        [1, nil, nil, nil, nil, nil, nil, nil],
        [1, nil, nil, nil, nil, nil, nil, nil],
        [1, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        ])
      end
      it "should return win" do
        result = cage.check_game_over
        expect(result).to eql 'win'
      end
    end

    context "player manage to create a left cross row" do
      before do
        cage.instance_variable_set(:@columns, [
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [1, nil, nil, 1, nil, nil, nil, nil],
        [2, 1, 1, 1, nil, nil, nil, nil],
        [1, 2, 2, 2, nil, nil, nil, nil],
        [1, 2, 2, 2, nil, nil, nil, nil],
        [2, 2, 1, 2, nil, nil, nil, nil],
        ])
      end
      it "should return win" do
        result = cage.check_game_over
        expect(result).to eql 'win'
      end
    end

    context "player manage to create a right cross row" do
      before do
        cage.instance_variable_set(:@columns, [
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [1, nil, nil, 1, nil, nil, nil, nil],
        [2, 1, 1, 2, nil, nil, nil, nil],
        [1, 2, 2, 2, nil, nil, nil, nil],
        [1, 2, 1, 2, nil, nil, nil, nil],
        [2, 2, 1, 1, nil, nil, nil, nil],
        ])
      end
      it "should return win" do
        result = cage.check_game_over
        expect(result).to eql 'win'
      end
    end

    context "no one has manage to create a row" do
      it "should return continue" do
        result = cage.check_game_over
        expect(result).to eql 'continue'
      end
    end

    context "the cage is full and no one wins" do
      before do
        cage.instance_variable_set(:@columns, [
          [1,2,1,2,1,2,1,2],
          [2,1,2,1,2,1,2,2],
          [2,1,2,1,2,1,2,1],
          [2,1,2,1,2,1,2,1],
          [1,2,1,2,1,2,1,2],
          [2,1,2,1,2,1,2,1],
          [2,1,2,1,2,1,2,1],
          [1,2,1,2,1,2,1,2],
        ])
      end
      it "should return draw" do
        result = cage.check_game_over
        expect(result).to eql 'draw'
      end
    end
  end
end