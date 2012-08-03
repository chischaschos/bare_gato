require 'spec_helper'

describe Player do
  subject do
    Player.new('X')
  end

  it "should be string friendly" do
    subject.dsplay.should == "X"
    subject.should == "X"
  end
end
