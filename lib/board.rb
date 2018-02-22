class Board

  def initialize
    @board_slots = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @board_map = {
      a: 0,
      b: 3,
      c: 6
    }
    @possible_wins = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  end

  def reset
    @board_slots = [0, 0, 0, 0, 0, 0, 0, 0, 0]
  end

  def render_slot(value)
    case value
      when 0 then ' '
      when 1 then 'X'
      when 2 then 'O'
    end
  end

  def display
    puts "\n    A   B   C  "
    puts "  +---+---+---+"
    puts "1 | #{render_slot(@board_slots[0])} | #{render_slot(@board_slots[3])} | #{render_slot(@board_slots[6])} |"
    puts "  +---+---+---+"
    puts "2 | #{render_slot(@board_slots[1])} | #{render_slot(@board_slots[4])} | #{render_slot(@board_slots[7])} |"
    puts "  +---+---+---+"
    puts "3 | #{render_slot(@board_slots[2])} | #{render_slot(@board_slots[5])} | #{render_slot(@board_slots[8])} |"
    puts "  +---+---+---+\n\n"
  end

  def play_slot(slot, symbol)
    index = @board_map[slot[0].to_sym] + slot[1].to_i - 1
    if(@board_slots[index] > 0)
      false
    else
      @board_slots[index] = symbol == 'X' ? 1 : 2
      true
    end
  end

  def check_win
    return @possible_wins.any? do |row|
      @board_slots[row[0]] == @board_slots[row[1]] && @board_slots[row[0]] == @board_slots[row[2]] && @board_slots[row[0]] != 0
    end
  end

end
