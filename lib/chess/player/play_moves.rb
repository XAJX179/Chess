# frozen_string_literal: true

# Chess
module Chess
  # Play all types of moves
  module PlayMovesByType
    # TODO: implement play_move_by_type
    def play_move_by_type(piece, board, move_pos)
      play_normal_move(piece, board, move_pos)
      change_player_turn(board)
    end

    def play_normal_move(piece, board, move_pos)
      board.remove_piece_at(piece.pos)
      board.remove_piece_at(move_pos)
      board.insert_piece_at(piece, move_pos)
    end
  end
end
