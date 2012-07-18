module BareGato
  class Game
    attr_accessor :strategies

    def initialize
      @grid = [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ]
    end

    def got_a_winner?
      strategies.each do |strategy_class|
        strategy = strategy_class.new @grid
        return true if strategy.winner?
      end

      return false
    end

    def next
      @last_move_type == 'o' ? 'x' : 'o'
    end

    def next? move_type
      !(@last_move_type == move_type.to_s)
    end

    def play move
      raise "Unexpected movement type" unless next? move.type
      @grid[move.y][move.x] = move.type
      @last_move_type = move.type
    end

    def status
      {
        game: @grid,
        next: self.next
      }
    end

  end
end
