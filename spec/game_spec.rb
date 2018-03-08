require 'game'
require 'board'

describe Game do

    before do 
        @players = {}
        @board = Board.new
        @game = Game.new(@players, @board)
    end

    describe "#game_over?" do
        context "given board.winning_row != nil" do
            it "#game_over? returns true" do
                allow(@board).to receive(:winning_row).and_return( true )

                expect(@game.game_over?).to eq(true)
            end
        end

        context "given none of the slots == 0" do
            
            before do
                allow(@board).to receive(:slots).and_return( Array.new(9) { 1 } )
            end

            it "#is_draw? returns true" do   
                expect(@game.is_draw?).to eq(true)
            end

            it "#game_over? returns true" do
                expect(@game.game_over?).to eq(true)
            end
        end
    end
    
    describe "#player_has_won?" do 
        context "given a winning row" do
            it "returns true" do
                allow(@board).to receive(:winning_row).and_return([0, 3, 6])
                expect(@game.player_has_won?).to eq(true)
            end
        end

        context "given no winning row" do
            it "returns false" do
                expect(@game.player_has_won?).to eq(false)
            end
        end
    end

    describe "#is_draw?" do 
        context "given a board that is full" do
            it "returns true" do
                allow(@board).to receive(:slots).and_return(Array.new(9) { 1 })
                expect(@game.is_draw?).to eq(true)
            end
        end

        context "given a board that is not full" do
            it "returns false" do
                allow(@board).to receive(:slots).and_return(Array.new(9) { 0 })
                expect(@game.is_draw?).to eq(false)
            end
        end
    end

    describe "#add_player" do
        context "given a name and a valid symbol" do
            it "players contains a player added" do   
                symbol = 'X'
                name = 'Kevin'

                @game.add_player(symbol, name)

                expect(@game.players.keys.include?(symbol.to_sym)).to eq(true)
                expect(@game.players[symbol.to_sym].marker).to eq(symbol)
                expect(@game.players[symbol.to_sym].name).to eq(name)
            end
        end

        context "given an invalid symbol" do
            it "raises and ArgumentError" do 
                symbol = 'T'
                name = 'Kevin'
                expected_msg = "invalid symbol, expected 'X' or 'O'"
  
                expect { @game.add_player(symbol, name) }.to raise_error(expected_msg, ArgumentError)
            end
        end
    end

end