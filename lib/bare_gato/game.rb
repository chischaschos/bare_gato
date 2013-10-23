module BareGato
  class Game
    attr_accessor :strategies

    def initialize args
      @grid = [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil],
      ]
      @players = args[:players]
    end

    def add_player player
      @players << player
    end

    def got_a_winner?
      !!strategies.find do |strategy_class|
        strategy = strategy_class.new @grid
        strategy.winner?
      end
    end

    def next
      @players.last
    end

    def next? player
      @players.last == player
    end

    def play move
      raise "Unexpected player moving" unless next? move.player
      @grid[move.y][move.x] = move.player
      @players.reverse!
    end

    def status
      {
        game: @grid,
        next: self.next
      }
    end

  end
end
