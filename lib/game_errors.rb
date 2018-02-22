class ExitError < StandardError

end

class InvalidSlotError < StandardError
  def initialize
    super("The slot you entered is not valid")
  end
end

class SlotTakenError < StandardError
  def initialize
    super("This slot is already taken")
  end
end
