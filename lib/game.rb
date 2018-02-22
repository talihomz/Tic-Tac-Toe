require '../bin/messages.rb' # remove all references to messages.rb
require_relative 'board.rb'
require 'pp'

class Game

  attr_reader :players

  Player = Struct.new(:name, :marker)

  # initialize this
  def initialize
    @players = Hash.new
    @board = Board.new
  end

  # resets the game
  def reset
    @current_player = 'O'
    @turn = 0
    @board.reset
  end

  # check if game is over
  def game_over?
    @board.check_win || is_draw?
  end

  # check if the game is a draw
  def is_draw?
    @turn == 9
  end

  # get current player
  def current_player
    @players[@current_player.to_sym].name
  end

  # add player to the game
  def add_player(symbol, name)
    player = Player.new(name, symbol)
    @players[player.marker.to_sym] = player
  end

  def player_has_won?
    @board.check_win
  end

  # switches player
  def switch_active_player
    @current_player = @current_player == 'O' ? 'X' : 'O'
  end

  def play_move(move)
    @board.fill_in_slot(move, @current_player)
    @board.display

    @turn += 1
  end

end
