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
      3.times do |y|
        # determine winner by row
        is_winner = @grid[y].uniq.size == 1 &&
          (@grid[y].uniq.first == 'o' ||
           @grid[y].uniq.first == 'x')
        return true if is_winner

        # determine winner by column
        column = []
        3.times do |x|
          column << @grid[y][x]
        end
        is_winner = column.uniq.size == 1 &&
          (column.uniq.first == 'o' ||
           column.uniq.first == 'x')
        return true if is_winner
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
