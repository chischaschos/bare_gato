class Game

  def initialize
    @grid = [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]
  end

  def play move
    @grid[move.y][move.x] = move.type
  end

  def status
    {
      game: @grid
    }
  end
end

class Move
  def initialize type, space

  end

end

describe Move do

end

describe Game do

  describe "a 3x3 game" do
    subject { Game.new }

    it "should be playable" do
      move = Move.new 'x', x: 0, y: 0
      subject.play move
    end

    it "should return the current game status" do
      subject.status.should eq({
        game: [['', '', ''],
               ['', '', ''],
               ['', '', '']]
      })
    end

    context "playing a few moves" do
      before do
        subject.play Move.new('x', x: 0, y: 0)
        subject.play Move.new('o', x: 1, y: 0)
        subject.play Move.new('x', x: 0, y: 2)
      end

      it "should return the current game status" do
        subject.status.should eq({
          game: [['x', 'o', ''],
                 ['',  '', ''],
                 ['',  'x', '']]
        })
      end

    end

  end
end
