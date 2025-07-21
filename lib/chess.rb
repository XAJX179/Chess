# frozen_string_literal: true

# the order of requiring here is important.
# requiring any gems/modules/class called in Game before requiring
# Game itself for example
require 'tty/prompt'
require 'json'
require_relative 'chess/display/color'
require_relative 'chess/display/prompt'
require_relative 'chess/display/board'
require_relative 'chess/mouse/mouse_position'
require_relative 'chess/mouse/mouse_input'
require_relative 'chess/save/serializer'
require_relative 'chess/save/save'
require_relative 'chess/pieces/piece'
require_relative 'chess/pieces/bishop'
require_relative 'chess/pieces/king'
require_relative 'chess/pieces/knight'
require_relative 'chess/pieces/pawn'
require_relative 'chess/pieces/queen'
require_relative 'chess/pieces/rook'
require_relative 'chess/board/board_pos'
require_relative 'chess/board/board_from_fen'
require_relative 'chess/board/board'
require_relative 'chess/player/play_moves'
require_relative 'chess/player/player'
require_relative 'chess/game'
require_relative 'chess/play_game'

# Chess
module Chess
  # calls {start_game} the script file at chess/play_game
  #
  # @return [void]
  def self.start
    start_game
  end
end
