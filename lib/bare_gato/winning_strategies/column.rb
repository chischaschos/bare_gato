module BareGato
  module WinningStrategies
    class Column
      def initialize grid
        @grid = grid
      end

      def winner?
        Row.new(@grid.transpose).winner?
      end

    end

  end
end
