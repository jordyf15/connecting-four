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
        result = cage.instance_variable_get(:@columns)[7][0]
        expect(result).to eql 1
      end
    end

    context "insert a piece to an already filled but not full column" do
      it "should fill the most empty bottom one in that column" do
        chosen_column = 7
        cage.insert_piece(player_number, chosen_column)
        result = cage.instance_variable_get(:@columns)[3][3]
        expect(result).to eql 1
      end
    end
  end

  describe "#check_cage?" do
    subject(:cage) {described_class.new}
    context "player manage to create a horizontal row" do
      before do
        cage.instance_variable_set(:@columns, [
          [nil, nil, nil, 1, 1, 1, 1, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
        ])
      end
      it "should return true" do
        result = cage.check_cage?
        expect(result).to eql true
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
      it "should return true" do
        result = cage.check_cage?
        expect(result).to eql true
      end
    end
    context "player manage to create a cross row" do
      before do
        cage.instance_variable_set(:@columns, [
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [1, nil, nil, 1, nil, nil, nil, nil],
        [1, 0, 1, 1, nil, nil, nil, nil],
        [1, 1, 0, 0, nil, nil, nil, nil],
        [1, 0, 0, 0, nil, nil, nil, nil],
        [0, 0, 1, 0, nil, nil, nil, nil],
        ])
      end
      it "should return true" do
        result = cage.check_cage?
        expect(result).to eql true
      end
    end

    context "no one has manage to create a row" do
      before do
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        (nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
      end
      it "should return false" do
        result = cage.check_cage?
        expect(result).to eql false
      end
    end
  end
end