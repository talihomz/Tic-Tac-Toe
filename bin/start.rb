#!/usr/bin/env ruby

require '../lib/game.rb'
require_relative 'messages.rb'

# setup
game = Game.new

# show welcome screen to the user
Menu.show_welcome

# start game loop
until game.game_over?
  # prompt the user for option
  option = Messages.select_option

  # player can only start the game if no players are set
  if(option == '1' && !game.players_set?)

    # add players
    game.add_player('X', Messages.get_player_name('X'))
    game.add_player('O', Messages.get_player_name('O'))

    Messages.show_game(self)

    @board.display
    @players_set = true
    # player 0 always starts first
    @current_player = 'O'
    # start the new round of tic-tac-toe
    play_game

  elsif(option == '2')
    user_wants_to_quit = Messages.confirm_exit
    if user_wants_to_quit
      @quit = true
      stop
    end
  else
    Messages.show_invalid_input(input)
  end
end
