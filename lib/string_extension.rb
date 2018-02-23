class String

  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def orange;         "\e[38;5;202m#{self}\e[0m" end
  def white;          "\e[38;5;241m#{self}\e[0m" end
  def yellow;         "\e[38;5;226m#{self}\e[0m" end
  def pink;           "\e[38;5;200m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end

end
