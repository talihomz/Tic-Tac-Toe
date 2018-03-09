require 'board'

describe Board do

  subject { Board.new }

  describe "#check_win" do
    context "given winning slots" do
      it "returns true" do
        subject.reset
        subject.instance_variable_set(:@slots, [0,1,0,0,1,0,0,1,0])

        expect(subject.check_win).to eq(true)
      end
    end

    # context "given winning slots" do
    #   it "returns true" do
    #     subject.reset
    #     subject.instance_variable_set(:@slots, [0,1,0,0,1,0,0,1,0])
    #
    #     expect(subject.check_win).to eq(true)
    #   end
    # end
  end

end
