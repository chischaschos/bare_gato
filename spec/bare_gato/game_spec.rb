require 'spec_helper'

module BareGato
  describe Game do

    let(:x_player) { Player.new 'x' }

    let(:o_player) { Player.new 'o' }

    it 'should compare multiple games' do
      game1 = described_class.new players: [Player.new('a'), Player.new('b')]
      game2 = described_class.new players: [Player.new('a'), Player.new('b')]
      expect(game1).to_not eq game2

      game2 = described_class.new players: [Player.new('a'), Player.new('b')], id: '123'
      game3 = described_class.new players: [Player.new('a'), Player.new('b')], id: '123'
      expect(game2).to eq game3

    end

    describe 'a 3x3 game' do
      subject do
        bare_gato_game = BareGato::Game.new players: [
          x_player, o_player
        ]
        bare_gato_game.strategies = [
          BareGato::WinningStrategies::Row,
          BareGato::WinningStrategies::Column,
          BareGato::WinningStrategies::Diagonal,
          BareGato::WinningStrategies::InverseDiagonal
        ]
        bare_gato_game
      end

      it 'should tell if a player belongs to a game' do
        expect(subject.includes_player? x_player).to be_true
        expect(subject.includes_player? o_player).to be_true
        expect(subject.includes_player? Player.new 'pepino').to be_false
      end

      it 'should start with the last added player' do
        expect(subject.next? o_player).to be_true
        move = Move.new o_player, x: 0, y: 0
        subject.play move
      end

      it 'should return the next move type' do
        subject.next.should eq(o_player)
      end

      it 'should keep movements sequence' do
        subject.play Move.new(o_player, x: 0, y: 0)
        expect(subject.next? o_player).to be_false
        expect(subject.next? x_player).to be_true

        subject.play Move.new(x_player, x: 1, y: 0)
        expect(subject.next? x_player).to be_false
        expect(subject.next? o_player).to be_true
      end

      it 'should return the current game status' do
        subject.status.should eq({
          game: [[nil, nil, nil],
                 [nil, nil, nil],
                 [nil, nil, nil]],
          next: o_player
        })
      end

      describe 'playing a few moves' do

        context 'providing correct moves order' do
          before do
            subject.play Move.new(o_player, x: 0, y: 0)
            subject.play Move.new(x_player, x: 1, y: 0)
            subject.play Move.new(o_player, x: 0, y: 2)
          end

          it 'should return the current game status' do
            subject.status.should eq({
              game: [[o_player, x_player, nil],
                     [nil, nil, nil],
                     [o_player,  nil, nil]],
              next: x_player
            })
          end
        end

        context 'providing incorrect moves order' do
          it 'should raise error' do
            expect { subject.play Move.new(x_player, x: 0, y: 0) }.to raise_error
            subject.play Move.new(o_player, x: 0, y: 0)
            subject.status.should eq({
              game: [[o_player, nil, nil],
                     [nil,  nil, nil],
                     [nil,  nil, nil]],
              next: x_player
            })
          end
        end
      end

      context 'a full game' do
        context 'when winning by column' do
          it 'should determine a winner' do
            subject.play Move.new(o_player, x: 0, y: 0)
            subject.got_a_winner?.should be_false

            subject.play Move.new(x_player, x: 1, y: 0)
            subject.got_a_winner?.should be_false

            subject.play Move.new(o_player, x: 2, y: 0)
            subject.got_a_winner?.should be_false

            subject.play Move.new(x_player, x: 1, y: 1)
            subject.got_a_winner?.should be_false

            subject.play Move.new(o_player, x: 2, y: 1)
            subject.got_a_winner?.should be_false

            subject.play Move.new(x_player, x: 1, y: 2)
            subject.status.should eq({
              game: [[o_player, x_player, o_player],
                     [nil,  x_player, o_player],
                     [nil,  x_player, nil]],
              next: o_player
            })
            subject.got_a_winner?.should be_true
          end
        end

        context 'when winning by row' do
          it 'should determine a winner' do
            subject.play Move.new(o_player, x: 0, y: 0)
            subject.got_a_winner?.should be_false

            subject.play Move.new(x_player, x: 0, y: 1)
            subject.got_a_winner?.should be_false

            subject.play Move.new(o_player, x: 1, y: 0)
            subject.got_a_winner?.should be_false

            subject.play Move.new(x_player, x: 1, y: 1)
            subject.got_a_winner?.should be_false

            subject.play Move.new(o_player, x: 2, y: 0)
            subject.status.should eq({
              game: [[o_player, o_player, o_player],
                     [x_player, x_player, nil],
                     [nil,  nil, nil]],
              next: x_player
            })
            subject.got_a_winner?.should be_true
          end
        end

        context 'when winning by diagonal' do
          it 'should determine a winner' do
            subject.play Move.new(o_player, x: 0, y: 0)
            subject.got_a_winner?.should be_false

            subject.play Move.new(x_player, x: 0, y: 1)
            subject.got_a_winner?.should be_false

            subject.play Move.new(o_player, x: 1, y: 1)
            subject.got_a_winner?.should be_false

            subject.play Move.new(x_player, x: 1, y: 0)
            subject.got_a_winner?.should be_false

            subject.play Move.new(o_player, x: 2, y: 2)
            subject.status.should eq({
              game: [[o_player, x_player, nil],
                     [x_player, o_player, nil],
                     [nil,  nil, o_player]],
              next: x_player
            })
            subject.got_a_winner?.should be_true
          end
        end

        context 'when winning by inverse diagonal' do
          it 'should determine a winner' do
            subject.play Move.new(o_player, x: 2, y: 0)
            subject.got_a_winner?.should be_false

            subject.play Move.new(x_player, x: 0, y: 1)
            subject.got_a_winner?.should be_false

            subject.play Move.new(o_player, x: 1, y: 1)
            subject.got_a_winner?.should be_false

            subject.play Move.new(x_player, x: 1, y: 0)
            subject.got_a_winner?.should be_false

            subject.play Move.new(o_player, x: 0, y: 2)
            subject.status.should eq({
              game: [[nil, x_player, o_player],
                     [x_player, o_player, nil],
                     [o_player,  nil, nil]],
              next: x_player
            })
            subject.got_a_winner?.should be_true
          end
        end

      end

    end
  end
end
