# frozen_string_literal: true

# Chess
module Chess
  # PlayKingMoves
  module PlayKingMoves
    def play_king_move(piece, board, move_pos)
      if castling_move?(piece, board, move_pos)
        play_castling_move(piece, board, move_pos)
      else
        play_normal_move(piece, board, move_pos)
      end
    end

    def castling_move?(piece, board, move_pos)
      castling_moves = piece.castling_moves(board)
      castling_moves.include?(move_pos)
    end

    def play_castling_move(piece, board, move_pos)
      play_normal_move(piece, board, move_pos)
      king_file = piece.pos.first
      king_rank = piece.pos.last
      if king_file == 'c'
        rook = board.piece_at('a', king_rank)
        rook_move_pos = ['d', king_rank]
        play_normal_move(rook, board, rook_move_pos)
      elsif king_file == 'g'
        rook = board.piece_at('h', king_rank)
        rook_move_pos = ['f', king_rank]
        play_normal_move(rook, board, rook_move_pos)
      end
    end
  end
end
