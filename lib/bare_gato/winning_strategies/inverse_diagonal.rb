module BareGato
  module WinningStrategies
    class InverseDiagonal
      def initialize grid
        @grid = grid
      end

      def winner?
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

    end

  end
end
