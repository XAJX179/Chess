# frozen_string_literal: true

# the order of requiring here is important.
# requiring any gems/modules/class called in Game before requiring
# Game itself for example
require 'tty/prompt'
require 'json'
require_relative 'chess/display/display'
require_relative 'chess/save/serializer'
require_relative 'chess/save/save'
require_relative 'chess/pieces'
require_relative 'chess/pieces/bishop'
require_relative 'chess/pieces/king'
require_relative 'chess/pieces/knight'
require_relative 'chess/pieces/pawn'
require_relative 'chess/pieces/queen'
require_relative 'chess/pieces/rook'
require_relative 'chess/board'
require_relative 'chess/player'
require_relative 'chess/game'

# Chess
module Chess
  # @return [Game]
  def self.new
    Game.new
  end
end
