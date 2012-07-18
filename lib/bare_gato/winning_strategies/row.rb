module BareGato
  module WinningStrategies
    class Row
      def initialize grid
        @grid = grid
      end

      def winner?
        3.times do |y|
          is_winner = @grid[y].uniq.size == 1 &&
            (@grid[y].uniq.first == 'o' ||
             @grid[y].uniq.first == 'x')
          return true if is_winner
        end

        return false
      end

    end

  end
end
