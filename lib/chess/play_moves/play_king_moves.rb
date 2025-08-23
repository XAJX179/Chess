# frozen_string_literal: true

# Chess
module Chess
  # PlayKingMoves
  module PlayKingMoves
    # plays the given castling move or normal move for king
    #
    # @param piece [Chess::Pieces::King]
    # @param board [Chess::Board]
    # @param move_pos [Array]
    # @return [void]
    def play_king_move(piece, board, move_pos)
      if castling_move?(piece, board, move_pos)
        play_castling_move(piece, board, move_pos)
      else
        play_normal_move(piece, board, move_pos)
      end
    end

    # check if move is a castling_move
    #
    # @param (see #play_king_move)
    def castling_move?(piece, board, move_pos)
      castling_moves = piece.castling_moves(board)
      castling_moves.include?(move_pos)
    end

    # plays the castling move (a special move which moves 2 pieces a king and a rook)
    #
    # @param (see #play_king_move)
    # @return [void]
    def play_castling_move(piece, board, move_pos)
      play_normal_move(piece, board, move_pos)
      play_rook_jump_move(piece, board, move_pos)
    end

    # plays the move of jumping rook over to the other side of king
    #
    # @param piece [Chess::Pieces::King]
    # @param board [Chess::Board]
    # @param rook_move_pos [Array]
    # @return [void]
    def play_rook_jump_move(piece, board, rook_move_pos) # rubocop:disable Metrics/MethodLength
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
