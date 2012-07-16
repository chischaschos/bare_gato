class Move
  attr_accessor :x, :y, :type
  def initialize type, space
    self.type = type
    self.x = space[:x]
    self.y = space[:y]
  end

  def valid?
    x > -1 &&
    y > -1 &&
    (type == 'x' || type == 'o')
  end

end
