# frozen_string_literal: true

# Chess
module Chess
  # Play all types of moves
  module PlayMovesByType
    include PlayPawnMoves
    include PlayKingMoves

    # play different move based on type of the piece
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param board [Chess::Board]
    # @param move_pos [Array]
    # @param inside_valid_moves_flag [Boolean]
    # @return [void]
    def play_move_by_type(piece, board, move_pos, inside_valid_moves_flag: false) # rubocop:disable Metrics/MethodLength
      update_player_board_data(piece, board, inside_valid_moves_flag)
      if piece.is_a?(Pieces::Pawn)
        play_pawn_move(piece, board, move_pos, inside_valid_moves_flag)
        board.reset_half_move unless inside_valid_moves_flag
      elsif piece.is_a?(Pieces::King)
        play_king_move(piece, board, move_pos)
      else
        play_normal_move(piece, board, move_pos)
      end
      change_player_turn(board)
      remove_en_passant_from_board(board) if @remove_en_passant
    end

    # play normal move
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param board [Chess::Board]
    # @param move_pos [Array]
    # @return [void]
    def play_normal_move(piece, board, move_pos)
      board.remove_piece_at(piece.pos)
      board.reset_half_move if board.piece_at(*move_pos).is_a?(Pieces::Piece)
      board.remove_piece_at(move_pos)
      board.insert_piece_at(piece, move_pos)
    end

    # update some player and board data
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param board [Chess::Board]
    # @param inside_valid_moves_flag [Boolean]
    # @return [void]
    def update_player_board_data(piece, board, inside_valid_moves_flag)
      board.half_move += 1 unless inside_valid_moves_flag
      @remove_en_passant = true
      board.full_move += 1 if !inside_valid_moves_flag && piece.black?
    end
  end
end
