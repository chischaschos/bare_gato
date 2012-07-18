module BareGato
  module WinningStrategies
    class Column
      def initialize grid
        @grid = grid
      end

      def winner?
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

        return false
      end

    end

  end
end
