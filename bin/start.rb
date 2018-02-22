#!/usr/bin/env ruby

require '../lib/game.rb'
require_relative 'messages.rb'

# setup
game = Game.new
option = "0"

# show welcome screen to the user
Menu.show_welcome

# start game loop
until option == "2"

  # prompt the user for option
  option = Messages.select_option

  # player can only start the game if no players are set
  if(option == '1' && !game.players_set?)

    # add players
    game.add_player('X', Messages.get_player_name('X'))
    game.add_player('O', Messages.get_player_name('O'))

    # prep the game
    game.prepare_game

    # display game to user
    Messages.show_game(game)

    # play the game
    # stop when game is stopped
    until game.game_over?

      begin
        player_move = Messages.get_player_move(game.current_player)

        # play the move
        game.play_move(player_move)

        # if you won, display
        if(game.player_has_won?)
          Messages.show_winner(game.current_player)
          game.reset
        else
          game.switch_active_player
        end

      rescue ArgumentError => e
        Messages.display_error e
        retry
      rescue SlotTakenError =>
        Messages.display_error e
        retry
      rescue ExitError => e
        break
      end
    end

  elsif(option == '2')
    user_wants_to_quit = Messages.confirm_exit
    option == "0" unless user_wants_to_quit
  else
    Messages.show_invalid_input(input)
  end
end
