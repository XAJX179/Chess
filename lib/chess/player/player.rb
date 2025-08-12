# frozen_string_literal: true

# Chess
module Chess
  # Player
  class Player
    include PlayMovesByType

    attr_accessor :selected_piece

    def initialize
      @selected_piece = ''
    end

    # select a move
    # @param board [Chess::Board]
    # @param move_pos [Array]
    def select_move(board, move_pos)
      if @selected_piece.valid_moves.include?(move_pos)
        play_move_by_type(@selected_piece, board, move_pos)
      else
        pp 'invalid move'
      end
    end

    def change_player_turn(board)
      current_player_color = board.current_player
      board.current_player = if current_player_color == 'w'
                               'b'
                             else
                               'w'
                             end
    end
  end
end
