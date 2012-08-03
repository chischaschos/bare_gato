require 'spec_helper'

describe BareGato::Game do

  let(:x_player) { Player.new 'x' }

  let(:o_player) { Player.new 'o' }

  describe "a 3x3 game" do
    subject do
      bare_gato_game = BareGato::Game.new
      bare_gato_game.strategies = [
        BareGato::WinningStrategies::Row,
        BareGato::WinningStrategies::Column,
        BareGato::WinningStrategies::Diagonal,
        BareGato::WinningStrategies::InverseDiagonal
      ]
      bare_gato_game
    end

    it "should be playable" do
      move = Move.new x_player, x: 0, y: 0
      subject.play move
    end

    it "should return the next move type" do
      subject.next.should eq(o_player)
    end

    it "should keep movements sequence" do
      subject.play Move.new(x_player, x: 0, y: 0)
      subject.next?(:x).should be_false
      subject.next?(:o).should be_true

      subject.play Move.new(o_player, x: 1, y: 0)
      subject.next?(:x).should be_true
    end

    it "should return the current game status" do
      subject.status.should eq({
        game: [['', '', ''],
               ['', '', ''],
               ['', '', '']],
        next: o_player
      })
    end

    describe "playing a few moves" do

      context "providing correct moves order" do
        before do
          subject.play Move.new(x_player, x: 0, y: 0)
          subject.play Move.new(o_player, x: 1, y: 0)
          subject.play Move.new(x_player, x: 0, y: 2)
        end

        it "should return the current game status" do
          subject.status.should eq({
            game: [[x_player, o_player, ''],
                   ['', '', ''],
                   [x_player,  '', '']],
            next: o_player
          })
        end
      end

      context "providing incorrect moves order" do
        before do
          subject.play Move.new(x_player, x: 0, y: 0)
        end

        it "should raise error" do
          expect { subject.play Move.new(x_player, x: 0, y: 2) }.to raise_error
          subject.status.should eq({
            game: [[x_player, '', ''],
                   ['',  '', ''],
                   ['',  '', '']],
            next: o_player
          })
        end
      end
    end

    context "a full game" do
      context "when winning by column" do
        it "should determine a winner" do
          subject.play Move.new(x_player, x: 0, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new(o_player, x: 1, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new(x_player, x: 2, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new(o_player, x: 1, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new(x_player, x: 2, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new(o_player, x: 1, y: 2)
          subject.status.should eq({
              game: [[x_player, o_player, x_player],
                     ['',  o_player, x_player],
                     ['',  o_player, '']],
              next: x_player
          })
          subject.got_a_winner?.should be_true
        end
      end

      context "when winning by row" do
        it "should determine a winner" do
          subject.play Move.new(x_player, x: 0, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new(o_player, x: 0, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new(x_player, x: 1, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new(o_player, x: 1, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new(x_player, x: 2, y: 0)
          subject.status.should eq({
              game: [[x_player, x_player, x_player],
                     [o_player, o_player, ''],
                     ['',  '', '']],
              next: o_player
          })
          subject.got_a_winner?.should be_true
        end
      end

      context "when winning by diagonal" do
        it "should determine a winner" do
          subject.play Move.new(x_player, x: 0, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new(o_player, x: 0, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new(x_player, x: 1, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new(o_player, x: 1, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new(x_player, x: 2, y: 2)
          subject.status.should eq({
              game: [[x_player, o_player, ''],
                     [o_player, x_player, ''],
                     ['',  '', x_player]],
              next: o_player
          })
          subject.got_a_winner?.should be_true
        end
      end

      context "when winning by inverse diagonal" do
        it "should determine a winner" do
          subject.play Move.new(x_player, x: 2, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new(o_player, x: 0, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new(x_player, x: 1, y: 1)
          subject.got_a_winner?.should be_false

          subject.play Move.new(o_player, x: 1, y: 0)
          subject.got_a_winner?.should be_false

          subject.play Move.new(x_player, x: 0, y: 2)
          subject.status.should eq({
              game: [['', o_player, x_player],
                     [o_player, x_player, ''],
                     [x_player,  '', '']],
              next: o_player
          })
          subject.got_a_winner?.should be_true
        end
      end

    end

  end
end
