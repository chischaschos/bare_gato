class Move
  attr_accessor :x, :y, :player

  def initialize player, space
    self.player = player
    self.x = space[:x]
    self.y = space[:y]
  end

  def valid?
    x > -1 && y > -1
  end

end
