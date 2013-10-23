require 'spec_helper'

describe BareGato::WinningStrategies::Diagonal do

  context "within a winner grid" do
    let(:grid) do
      [
        [ 'x', nil, 'o' ] ,
        [ nil, 'x', nil ] ,
        [ nil, 'o', 'x' ]
      ]
    end

    subject do
      BareGato::WinningStrategies::Diagonal.new grid
    end

    it "returns a winner" do
      subject.winner?.should be_true
    end
  end

  context "within a loser grid" do
    let(:grid) do
      [
        [ nil,  'x', 'x' ] ,
        [ 'o', 'x', 'o' ] ,
        [ nil,  nil,  nil ]
      ]
    end

    subject do
      BareGato::WinningStrategies::Diagonal.new grid
    end

    it "returns a winner" do
      subject.winner?.should be_false
    end
  end
end
