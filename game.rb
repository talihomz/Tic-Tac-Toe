require './menu.rb'
require './board.rb'
require 'pp'

class Game

  attr_reader :players

  Player = Struct.new(:name, :marker)

  # initialize this
  def initialize
    @players = Hash.new
    @players_set = false
    @stop_game = false
    @board = Board.new
  end

  # enter the game menu
  def start
    Menu.show_welcome

    # game loop
    until game_over?
      input = gets.chomp

      # player can only start the game if no players are set
      if(input == '1' && !@players_set)

        # add players
        add_player('X')
        add_player('O')

        Menu.show_game(self)

        @board.display
        @players_set = true
        # player 0 always starts first
        @current_player = 'O'
        # start the new round of tic-tac-toe
        play_game

      elsif(input == '2')
        puts "Are you sure you want to quit? (y/n)"
        response = gets.chomp

        if response.downcase == 'y'
          @quit = true
          stop
        end
      else
        puts "Input '#{input}' is invalid!"
      end
    end

  end

  def stop
    puts "It was nice having you, bye!"
  end

  def game_over?
    @quit
  end

  def prompt_user
    input = gets.chomp
  end

  def add_player(symbol)
    print "Player #{symbol}, please choose your name: "
    player_name = gets.chomp
    player = Player.new(player_name, symbol)
    @players[player.marker.to_sym] = player
  end

  def exit_game
    @stop_game = true
    @players_set = false
    @board.reset
    Menu.show_welcome
  end

  def play_game

    @turn = 0
    @stop_game = false

    until @stop_game

      # 1. Prompt player for Input
      print "#{@players[@current_player.to_sym].name}'s turn: "
      player_input = gets.chomp

      if(player_input == '2')

        puts "Are you sure you want to quit? (y/n)"
        response = gets.chomp
        @stop_game = true if response.downcase == 'y'

      elsif player_input.downcase.match(/^([abc]{1})([123]{1})$/) == nil
        # handle invalid input
        puts 'Hey, this is not chess!! Please enter a valid slot'
      else

        if(@board.play_slot(player_input, @current_player))

          # display the board
          @board.display

          # increase turn count
          @turn += 1

          # check for winning state
          if(@board.check_win)
            puts "#{@players[@current_player.to_sym].name} has won the game!"
            @stop_game = true
          else
            # check if we should exit the game
            @stop_game = true if @turn == 9

            # switch current player
            @current_player = @current_player == 'O' ? 'X' : 'O'
          end
        else
          puts "That slot is already occupied! Try another slot"
        end
      end
    end

    exit_game
  end

  # defining scope
  public :start
  private :game_over?, :stop
end
