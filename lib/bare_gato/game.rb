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
      # determine winner by row
      3.times do |y|
        is_winner = @grid[y].uniq.size == 1 &&
          (@grid[y].uniq.first == 'o' ||
           @grid[y].uniq.first == 'x')
        return true if is_winner

      end

      # determine winner by column
      3.times do |x|
        column = []
        column << @grid[0][x]
        column << @grid[1][x]
        column << @grid[2][x]

        is_winner = column.uniq.size == 1 &&
          (column.uniq.first == 'o' ||
           column.uniq.first == 'x')
        return true if is_winner
      end

      diagonal = []
      3.times do |index|
        diagonal << @grid[index][index]
      end
      is_winner = diagonal.uniq.size == 1 &&
        (diagonal.uniq.first == 'o' ||
         diagonal.uniq.first == 'x')
      return true if is_winner

      diagonal = []
      3.times do |index|
        diagonal << @grid[index][2 - index]
      end
      is_winner = diagonal.uniq.size == 1 &&
        (diagonal.uniq.first == 'o' ||
         diagonal.uniq.first == 'x')
      return true if is_winner

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
