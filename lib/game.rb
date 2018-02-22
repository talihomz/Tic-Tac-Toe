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

  def prepare_game
    reset
    @players_set = true
  end

  def reset
    @current_player = 'O'
    @turn = 0
    @players_set = false
    @board.reset
  end

  def players_set?
    @players_set
  end

  def game_over?
    @board.check_win || @turn == 9
  end

  def is_stopped?
    @stop_game
  end

  def check_draw

  end

  def current_player
    @players[@current_player.to_sym].name
  end

  def add_player(symbol, name)
    player = Player.new(name, symbol)
    @players[player.marker.to_sym] = player
  end

  def player_has_won?
    @board.check_win
  end

  def switch_active_player
    @current_player = @current_player == 'O' ? 'X' : 'O'
  end

  def play_move(move)
    @board.fill_in_slot(move, @current_player)
    @board.display

    @turn += 1
  end

  # defining scope
  public :start
  private :game_over?, :stop
end
