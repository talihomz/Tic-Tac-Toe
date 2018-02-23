#!/usr/bin/env ruby

require_relative '../lib/game.rb'
require_relative 'messages.rb'

# setup
game = Game.new
option = "0"

# show welcome screen to the user
Messages.show_welcome

# start game loop
until option == "2"

  # prompt the user for option
  option = Messages.select_option

  # player can only start the game if no players are set
  if(option == '1')
    # prepare (reset) the game
    game.reset

    # add players
    game.add_player('X', Messages.get_player_name('X'))
    game.add_player('O', Messages.get_player_name('O'))

    # display game to user
    Messages.show_game(game)

    # play the game until the game is over
    until game.game_over?

      begin
        player_move = Messages.get_player_move(game.current_player)

        # go next iteration if player chose "n" on the quit instruction
        next if player_move == "n"

        # play the move
        game.play_move(player_move)

        # if you won, display
        if(game.player_has_won?)
          Messages.show_winner(game.current_player)
        else
          game.switch_active_player
        end

      rescue InvalidSlotError => e
        Messages.display_error e
        retry
      rescue SlotTakenError => e
        Messages.display_error e
        retry
      rescue ExitError => e
        break
      end
    end

  elsif(option == '2')
    user_wants_to_quit = Messages.confirm_exit
    if user_wants_to_quit
      Messages.say_goodbye
      break
    else
      option = "0"
    end
  else
    Messages.show_invalid_input(option)
  end
end
