# frozen_string_literal: true

require_relative 'chess/game'
require_relative 'chess/player'
require_relative 'chess/board'
require_relative 'chess/pieces'
require_relative 'chess/pieces/bishop'
require_relative 'chess/pieces/king'
require_relative 'chess/pieces/knight'
require_relative 'chess/pieces/pawn'
require_relative 'chess/pieces/queen'
require_relative 'chess/pieces/rook'

# Chess
module Chess
  def self.new
    Game.new
  end
end
