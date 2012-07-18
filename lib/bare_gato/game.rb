module BareGato
  class Game
    def initialize
      @grid = [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ]
    end

    def got_a_winner?
      row = BareGato::WinningStrategies::Row.new @grid
      return true if row.winner?

      row = BareGato::WinningStrategies::Column.new @grid
      return true if row.winner?

      row = BareGato::WinningStrategies::Diagonal.new @grid
      return true if row.winner?

      row = BareGato::WinningStrategies::InverseDiagonal.new @grid
      return true if row.winner?

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
