require 'spec_helper'
require 'bare_gato/winning_strategies/row'

describe BareGato::WinningStrategies::Row do

  context "within a winner grid" do
    let(:grid) do
      [
        ['',  'x', 'x'],
        ['o', 'o', 'o'],
        ['',  '',  '']
      ]
    end

    subject do
      BareGato::WinningStrategies::Row.new grid
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
      BareGato::WinningStrategies::Row.new grid
    end

    it "returns a winner" do
      subject.winner?.should be_false
    end
  end
end
