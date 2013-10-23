module BareGato
  class Move
    attr_reader :x, :y, :player

    def initialize player, space
      @player = player
      @x = space[:x]
      @y = space[:y]
    end

    def valid?
      x > -1 && y > -1
    end
  end
end
