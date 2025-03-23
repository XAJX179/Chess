# frozen_string_literal: true

require_relative 'chess/game'
require_relative 'chess/player'
require_relative 'chess/board'
require_relative 'chess/pieces'

# Chess
module Chess
  def self.new
    Game.new
  end
end
