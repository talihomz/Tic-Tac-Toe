require 'board'
require 'game_errors'

describe Board do

  subject { Board.new }

  describe "#check_win" do
    shared_examples "win_example" do |parameter|
      it "Slots #{parameter} return true" do
        subject.reset
        subject.instance_variable_set(:@slots, parameter)
        expect(subject.check_win).to eq(true)
      end
    end

    context "given a collection of winning slots" do
      winning_slots = [
        [0,1,0,0,1,0,0,1,0],
        [1,0,0,1,0,0,1,0,0],
        [0,0,1,0,0,1,0,0,1],
        [1,1,1,0,0,0,0,0,0],
        [0,0,0,1,1,1,0,0,0],
        [0,0,0,0,0,0,1,1,1],
        [1,0,0,0,1,0,0,0,1],
        [0,0,1,0,1,0,1,0,0]
      ]
      winning_slots.each do |slot|
        include_examples "win_example", slot
      end

    end

    context "given non winning slots" do
      it "returns false" do
        subject.reset

        expect(subject.check_win).to eq(false)
      end
    end
  end

  describe "#fill_in_slot" do
    shared_examples "invalid_slot" do |slot|
      it "Input '#{slot}' raises an error" do
        expect { subject.fill_in_slot(slot, 'X') }.to raise_error(InvalidSlotError)
      end
    end

    context "given invalid slot" do
      ['a4', 'aa', '11', 'aa11', '', 'a11', '1a', '&3', 'd1'].each do |slot|
        include_examples "invalid_slot", slot
      end

      # it "raises InvalidSlotError" do
      #
      # end
    end
  end
end
