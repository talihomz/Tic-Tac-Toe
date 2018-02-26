require_relative "board.rb"
require "pp"

class Game

  attr_reader :players
  attr_reader :board

  Player = Struct.new(:name, :marker)

  def initialize
    @players = Hash.new
    @board = Board.new
  end

  def reset
    @current_player = "O"
    @board.reset
  end

  def game_over?
    player_has_won? || is_draw?
  end

  # game is a draw if all slots are played (not 0)
  def is_draw?
    @board.slots.all? do |slot| slot != 0 end
  end

  # get current player
  def current_player
    @players[@current_player.to_sym].name
  end

  def add_player(symbol, name)
    player = Player.new(name, symbol)
    @players[player.marker.to_sym] = player
  end

  def player_has_won?
    @board.winning_row
  end

  def switch_active_player
    @current_player = @current_player == "O" ? "X" : "O"
  end

  def play_move(move)
    @board.fill_in_slot(move, @current_player)
    @board.check_win
    Messages.show @board
  end

end
