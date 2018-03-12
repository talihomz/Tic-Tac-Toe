require 'board'
require 'game_errors'

describe Board do

  subject { Board.new }

  describe "#check_win" do
    shared_examples "win_example" do |input|
      it "Input '#{input.join(",")}' returns true" do
        subject.reset
        input.each do |move|
          subject.fill_in_slot(move, 'X')
        end
        expect(subject.check_win).to eq(true)
      end
    end

    context "when input is a winning combination" do
      winning_slots = [
        ['a1', 'b1', 'c1'],
        ['a2', 'b2', 'c2'],
        ['a3', 'b3', 'c3'],
        ['a1', 'a2', 'a3'],
        ['b1', 'b2', 'b3'],
        ['c1', 'c2', 'c3'],
        ['a1', 'b2', 'c3'],
        ['c1', 'b2', 'a3']
      ]
      winning_slots.each do |slot|
        include_examples "win_example", slot
      end

    end

    context "when no winning input" do
      it "returns false" do
        subject.reset

        expect(subject.check_win).to eq(false)
      end
    end
  end

  describe "#fill_in_slot" do
    shared_examples "invalid_slot" do |slot|
      it "Input '#{slot}' raises an InvalidSlotError" do
        expect { subject.fill_in_slot(slot, 'X') }.to raise_error(InvalidSlotError)
      end
    end

    context "when invalid inputs" do
      ['a4', 'aa', '11', 'aa11', '', 'a11', '1a', '&3', 'd1'].each do |slot|
        include_examples "invalid_slot", slot
      end
    end

    context "when a taken slot as input" do
      it "raises a SlotTakenError" do
        allow(subject).to receive(:slot_taken?).and_return( true )

        expect { subject.fill_in_slot('a1', 'X') }.to raise_error(SlotTakenError)
      end
    end
  end
end
