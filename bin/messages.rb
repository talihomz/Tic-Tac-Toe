require "../lib/game_errors"

class Messages

  def self.show_welcome
    puts %{
===========================================
   TIC TAC TOE : By Sava & Kevin
===========================================

Welcome to Tic Tac Toe. Play if you dare 😈
    }
  end

  def self.select_option
    puts %{
  1. Start game
  2. Quit
    }

    print 'Choose your destiny... '
    input = gets.chomp
    input
  end

  def self.show_game(game)
    message = "\n\n#{game.players[:X].name} vs #{game.players[:O].name}"
    instructions = %{
===========================================

Instructions:
1. Each player gets a turn at the game
  - The prompt will show who's turn it is (e.g. Kevin's Turn: )
2. Enter the position you wish to mark (e.g A2)
3. Press '2' to quit the game any time.
}

    puts "#{message}#{instructions}"
  end

  def self.confirm_exit
    print "Are you sure you want to quit? (y/n)"
    input = gets.chomp
    input.downcase == 'y'
  end

  def show_invalid_input(input)
    puts "Input '#{input}' is invalid!"
  end

  def self.display_error e
    puts "Error! => #{e.message}"
  end

  def self.get_player_name(symbol)
    print "Player #{symbol}, please choose your name: "
    player_name = gets.chomp
  end

  def self.get_player_move(player)

    # 1. Prompt player for Input
    print "#{player}'s turn: "
    player_input = gets.chomp
    player_input = player_input.downcase

    # quit
    if player_input == "q"
      puts "Are you sure you want to quit? (y/n)"
      response = gets.chomp
      raise ExitError.new if response.downcase == 'y'
    end

    player_input
  end

  def self.show_winner player
    puts "Congratulations #{player}, you've won the game!"
  end

end
