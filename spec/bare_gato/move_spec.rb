require 'spec_helper'

module BareGato
  describe Move do
    it "should accept valid movements" do
      player = Player.new 'x'

      move = Move.new player, x: 0, y: 0
      move.valid?.should be_true
    end

    it "should not accept invalid indexes" do
      player = Player.new 'x'

      move = Move.new player, x: -1, y: 0
      move.valid?.should_not be_true

      move = Move.new player, x: 0, y: -1
      move.valid?.should_not be_true
    end
  end
end
