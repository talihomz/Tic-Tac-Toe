require 'board'

describe Board do

  subject("board") { Board.new }
  subject("winning_slots") {
    [
      [0,1,0,0,1,0,0,1,0],
      [1,0,0,1,0,0,1,0,0],
      [0,0,1,0,0,1,0,0,1],
      [1,1,1,0,0,0,0,0,0],
      [0,0,0,1,1,1,0,0,0],
      [0,0,0,0,0,0,1,1,1],
      [1,0,0,0,1,0,0,0,1],
      [0,0,1,0,1,0,1,0,0]
    ]
  }

  describe "#check_win" do

    shared_examples "win_example" do |parameter|
      it "Slot at #{parameter} returns true" do
        board.reset
        board.instance_variable_set(:@slots, winning_slots[parameter])
        expect(board.check_win).to eq(true)
      end
    end

    context "given a collection of winning slots" do
      8.times do |index|
        include_examples "win_example", index
      end
      
    end

    # context "given winning slots" do
    #   it "returns false" do
    #     board.reset
        
    #     expect(board.check_win).to eq(true)
    #   end
    # end
  end

end
