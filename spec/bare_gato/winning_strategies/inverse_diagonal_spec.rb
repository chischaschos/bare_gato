require 'spec_helper'

describe BareGato::WinningStrategies::InverseDiagonal do

  context "within a winner grid" do
    let(:grid) do
      [
        ['o', '',  'x'],
        ['',  'x', ''],
        ['x', 'o', '']
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
        ['',  'x', 'x'],
        ['o', 'x', 'o'],
        ['',  '',  '']
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
