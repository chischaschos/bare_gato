module BareGato
  module WinningStrategies
    class Diagonal
      def initialize grid
        @grid = grid
      end

      def winner?
        diagonal = []
        @grid.size.times do |index|
          diagonal << @grid[index][index]
        end

        diagonal.compact.size == @grid.size && diagonal.compact.uniq.size == 1
      end

    end

  end
end
