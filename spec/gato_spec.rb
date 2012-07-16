class Game

  def initialize
    @grid = [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ]
  end

  def next
    @last_move_type == 'o' ? 'x' : 'o'
  end

  def next? move_type
    !(@last_move_type == move_type.to_s)
  end

  def play move
    raise "Unexpected movement type" unless next? move.type
    @grid[move.x][move.y] = move.type
    @last_move_type = move.type
  end

  def status
    {
      game: @grid,
      next: self.next
    }
  end
end

class Move
  attr_accessor :x, :y, :type
  def initialize type, space
    self.type = type
    self.x = space[:x]
    self.y = space[:y]
  end

  def valid?
    x > -1 &&
    y > -1 &&
    (type == 'x' || type == 'o')
  end

end

describe Move do
  it "should accept valid movements" do
    move = Move.new 'x', x: 0, y: 0
    move.valid?.should be_true
  end

  it "should not accept invalid indexes" do
    move = Move.new 'x', x: -1, y: 0
    move.valid?.should_not be_true


    move = Move.new 'x', x: 0, y: -1
    move.valid?.should_not be_true
  end

  it "should not accept invalid types" do
    move = Move.new 'P', x: 0, y: 0
    move.valid?.should_not be_true


    move = Move.new 'X', x: 0, y: 0
    move.valid?.should_not be_true
  end
end

describe Game do

  describe "a 3x3 game" do
    subject { Game.new }

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
            game: [['x', '', 'x'],
                   ['o', '', ''],
                   ['',  '', '']],
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

  end
end
