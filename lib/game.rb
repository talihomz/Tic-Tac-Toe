require_relative 'board.rb'
require 'pp'

class Game
  attr_reader :players
  attr_reader :board

  Player = Struct.new(:name, :marker)

  def initialize(board, players = {})
    raise ArgumentError.new('Board cannot be nil') if board.nil?
    raise TypeError.new('Expected instance of board as first argument') unless board.instance_of?(Board)

    @players = players
    @board = board
  end

  def reset
    @current_player = 'O'
    @board.reset
  end

  def game_over?
    player_has_won? || is_draw?
  end

  def is_draw?
    # game is a draw if all slots are played (not 0)
    @board.slots.all? { |slot| slot != 0 }
  end

  def current_player
    @players[@current_player.to_sym].name
  end

  def add_player(symbol, name)
    raise ArgumentError, "invalid symbol, expected 'X' or 'O'" if symbol =~ /[^XO]/i
    player = Player.new(name, symbol)
    @players[player.marker.to_sym] = player
  end

  def player_has_won?
    @board.winning_row ? true : false
  end

  def switch_active_player
    @current_player = @current_player == 'O' ? 'X' : 'O'
  end

  def play_move(move)
    @board.fill_in_slot(move, @current_player)
    @board.check_win
  end
end
