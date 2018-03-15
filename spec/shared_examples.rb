shared_examples 'win_example' do |input|
    it "Input '#{input.join(',')}' returns true" do
        subject.reset
        input.each do |move|
        subject.fill_in_slot(move, 'X')
        end
        expect(subject.check_win).to eq(true)
    end
end

shared_examples 'invalid_slot' do |slot|
    it "Input '#{slot}' raises an InvalidSlotError" do
        expect { subject.fill_in_slot(slot, 'X') }.to raise_error(InvalidSlotError)
    end
end