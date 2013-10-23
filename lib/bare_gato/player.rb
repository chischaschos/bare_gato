class Player

  attr_reader :display

  def initialize display
    @display = display
  end

  def == other
    other.display == display
  end
end
