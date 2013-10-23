require 'spec_helper'

describe BareGato::WinningStrategies::InverseDiagonal do

  context "within a winner grid" do
    let(:grid) do
      [
        [ 'o', nil,  'x' ],
        [ nil,  'x', nil ],
        [ 'x', 'o', nil ]
      ]
    end

    subject do
      BareGato::WinningStrategies::InverseDiagonal.new grid
    end

    it "returns a winner" do
      subject.winner?.should be_true
    end
  end

  context "within a loser grid" do
    let(:grid) do
      [
        [ nil,  'x', 'x' ],
        [ 'o', 'x', 'o' ],
        [ nil,  nil,  nil ]
      ]
    end

    subject do
      BareGato::WinningStrategies::InverseDiagonal.new grid
    end

    it "returns a winner" do
      subject.winner?.should be_false
    end
  end
end
