require_relative 'string_extension'

class Board

  attr_reader :slots
  attr_reader :winning_row

  def initialize
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
    @slots = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @winning_row = nil
  end

  def render_slot(position)
    value = @slots[position]
    render = ' '

    case value
      when 1 then render = 'X'
      when 2 then render = 'O'
    end

    if @winning_row != nil
      render = @winning_row.include?(position) ? render.green.bold : render.red
    end

    return render
  end

  def to_s
    return %{
        A   B   C
      +---+---+---+
    1 | #{render_slot(0)} | #{render_slot(3)} | #{render_slot(6)} |
      +---+---+---+
    2 | #{render_slot(1)} | #{render_slot(4)} | #{render_slot(7)} |
      +---+---+---+
    3 | #{render_slot(2)} | #{render_slot(5)} | #{render_slot(8)} |
      +---+---+---+

}
  end

  def fill_in_slot(slot, symbol)

    # handle invalid input
    if slot.match(/^([abc]{1})([123]{1})$/) == nil
      raise InvalidSlotError.new
    end

    if(!slot_taken?(slot))
      index = get_slot_index(slot)
      @slots[index] = symbol == 'X' ? 1 : 2
    else
      raise SlotTakenError.new
    end
  end

  def slot_taken?(slot)
    index = get_slot_index(slot)
    @slots[index] > 0
  end

  def get_slot_index(slot)
    @board_map[slot[0].to_sym] + slot[1].to_i - 1
  end

  def check_win
    @winning_row = @possible_wins.find do |row|
      @slots[row[0]] == @slots[row[1]] && @slots[row[0]] == @slots[row[2]] && @slots[row[0]] != 0
    end
  end

end
