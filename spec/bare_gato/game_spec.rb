require 'spec_helper'

describe BareGato::Game do

  describe "a 3x3 game" do
    subject { BareGato::Game.new }

    it "should be playable" do
      move = Move.new 'x', x: 0, y: 0
      subject.play move
    end

    it "should return the next move type" do
      subject.next.should eq('o')
    end

    it "should keep movements sequence" do
      subject.play Move.new('x', x: 0, y: 0)
      subject.next?(:x).should be_false
      subject.next?(:y).should be_true

      subject.play Move.new('y', x: 1, y: 0)
      subject.next?(:x).should be_true
    end

    it "should return the current game status" do
      subject.status.should eq({
        game: [['', '', ''],
               ['', '', ''],
               ['', '', '']],
        next: 'o'
      })
    end

    describe "playing a few moves" do

      context "providing correct moves order" do
        before do
          subject.play Move.new('x', x: 0, y: 0)
          subject.play Move.new('o', x: 1, y: 0)
          subject.play Move.new('x', x: 0, y: 2)
        end

        it "should return the current game status" do
          subject.status.should eq({
            game: [['x', 'o', ''],
                   ['', '', ''],
                   ['x',  '', '']],
            next: 'o'
          })
        end
      end

      context "providing incorrect moves order" do
        before do
          subject.play Move.new('x', x: 0, y: 0)
        end

        it "should raise error" do
          expect { subject.play Move.new('x', x: 0, y: 2) }.to raise_error
          subject.status.should eq({
            game: [['x', '', ''],
                   ['',  '', ''],
                   ['',  '', '']],
            next: 'o'
          })
        end
      end
    end

    context "a full game" do
      context "when winning by column" do
        it "should determine a winner" do
          subject.play Move.new('x', x: 0, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new('o', x: 1, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new('x', x: 2, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new('o', x: 1, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new('x', x: 2, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new('o', x: 1, y: 2)
          subject.status.should eq({
              game: [['x', 'o', 'x'],
                     ['',  'o', 'x'],
                     ['',  'o', '']],
              next: 'x'
          })
          subject.got_a_winner?.should be_true
        end
      end

      context "when winning by row" do
        it "should determine a winner" do
          subject.play Move.new('x', x: 0, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new('o', x: 0, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new('x', x: 1, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new('o', x: 1, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new('x', x: 2, y: 0)
          subject.status.should eq({
              game: [['x', 'x', 'x'],
                     ['o', 'o', ''],
                     ['',  '', '']],
              next: 'o'
          })
          subject.got_a_winner?.should be_true
        end
      end

      context "when winning by diagonal" do
        it "should determine a winner" do
          subject.play Move.new('x', x: 0, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new('o', x: 0, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new('x', x: 1, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new('o', x: 1, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new('x', x: 2, y: 2)
          subject.status.should eq({
              game: [['x', 'o', ''],
                     ['o', 'x', ''],
                     ['',  '', 'x']],
              next: 'o'
          })
          subject.got_a_winner?.should be_true
        end
      end

      context "when winning by inverse diagonal" do
        it "should determine a winner" do
          subject.play Move.new('x', x: 2, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new('o', x: 0, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new('x', x: 1, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new('o', x: 1, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new('x', x: 0, y: 2)
          subject.status.should eq({
              game: [['', 'o', 'x'],
                     ['o', 'x', ''],
                     ['x',  '', '']],
              next: 'o'
          })
          subject.got_a_winner?.should be_true
        end
      end

    end

  end
end
