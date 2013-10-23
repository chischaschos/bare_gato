module BareGato
  module WinningStrategies
    class Row
      def initialize grid
        @grid = grid
      end

      def winner?
        !!@grid.find do |row|
          row.compact.size == row.size && row.uniq.compact.size == 1
        end
      end

    end

  end
end
