require 'Game'
require 'Board'

describe Game do

    before do 
        @players = {}
        @board = Board.new
        @game = Game.new(@players, @board)
    end

    describe "winning condition" do
        context "given board.winning_row != nil" do
            it "#game_over? returns true" do
                # arrange
                allow(@board).to receive(:winning_row).and_return( true )

                # act

                # assert
                expect(@game.game_over?).to eq(true)
            end
        end

        context "given none of the slots == 0" do
            
            before do
                allow(@board).to receive(:slots).and_return( Array.new(9) { 1 } )
            end

            it "#is_draw? returns true" do
                # arrange               

                # act

                # assert
                expect(@game.is_draw?).to eq(true)
            end

            it "#game_over? returns true" do
                # arrange               

                # act

                # assert
                expect(@game.game_over?).to eq(true)
            end
        end
    end    
end