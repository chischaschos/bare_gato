require 'spec_helper'

describe Move do
  it "should accept valid movements" do
    move = Move.new 'x', x: 0, y: 0
    move.valid?.should be_true
  end

  it "should not accept invalid indexes" do
    move = Move.new 'x', x: -1, y: 0
    move.valid?.should_not be_true


    move = Move.new 'x', x: 0, y: -1
    move.valid?.should_not be_true
  end

  it "should not accept invalid types" do
    move = Move.new 'P', x: 0, y: 0
    move.valid?.should_not be_true


    move = Move.new 'X', x: 0, y: 0
    move.valid?.should_not be_true
  end
end
