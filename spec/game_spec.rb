require 'game'
require 'board'

describe Game do

    before do 
        @board = Board.new
        @game = Game.new(@board)
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
                expect(@game.players[symbol.to_sym]).to have_attributes(marker: symbol)
                expect(@game.players[symbol.to_sym]).to have_attributes(name: name)
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

    describe "#reset" do
        before do
            @game.add_player("X", "Kevin")
            @game.add_player("O", "Sava")
        end

        it "calls board.reset" do
            expect(@board).to receive(:reset)

            # act
            @game.reset
        end

        it "sets current player to 'O'" do
            
            @game.reset

            # assert
            expect(@game.current_player).to eq("Sava")
        end
    end

    describe "#switch_active_player" do
        before do
            @game.add_player("X", "Kevin")
            @game.add_player("O", "Sava")
            @game.reset
        end

        it "returns Kevin on 1 switch" do
            @game.switch_active_player

            expect(@game.current_player).to eq("Kevin")
        end

        it "returns Sava on 2 switches" do
            2.times { @game.switch_active_player }

            expect(@game.current_player).to eq("Sava")
        end
    end

    describe "#play_move" do
        before do
            @game.add_player("X", "Kevin")
            @game.add_player("O", "Sava")
            @game.reset
        end

        it "checks for a win on the board" do
            expect(@board).to receive(:check_win)
            valid_move = "a1"

            # act
            @game.play_move(valid_move)
        end

        context "given current_player is 'O'" do
            it "invokes board.fill_in_slot with correct arguments" do
                valid_move = "a1"
                current_player = "O"
                expect(@board).to receive(:fill_in_slot).with(valid_move, current_player)
    
                # act
                @game.play_move(valid_move)
            end
        end   
        
        context "given current_player is 'X'" do
            it "invokes board.fill_in_slot with correct arguments" do
                valid_move = "a1"
                current_player = "X"
                expect(@board).to receive(:fill_in_slot).with(valid_move, current_player)
    
                # act
                @game.switch_active_player
                @game.play_move(valid_move)
            end
        end
    end

end