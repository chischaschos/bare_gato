require 'spec_helper'

describe Player do
  subject do
    Player.new('X')
  end

  it "should be string friendly" do
    subject.display.should == "X"
  end

  it 'should identify players' do
    expect(Player.new 'X' ).to eq Player.new('X')
    expect(Player.new 'X' ).to_not eq Player.new('R')
  end

end
