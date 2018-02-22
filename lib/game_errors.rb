class ExitError < Error

end

class InvalidSlot < Error
  def initialize
    super("The slot you entered is not valid")
  end
end

class SlotTakenError < Error
  def initialize
    super("This slot is already taken")
  end
end
