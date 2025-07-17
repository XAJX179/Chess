# frozen_string_literal: true

# Chess
module Chess
  # Play all types of moves
  module PlayMovesByType
    # TODO: implement play_move_by_type
    def play_move_by_type(board, board_pos)
      if @selected_piece.is_a? Pieces::King
        pp 'king selected'
      elsif @selected_piece.is_a? Pieces::Pawn
        pp 'pawn selected'
        pawn_move(board, board_pos)
      else
        pp 'others selected'
        play_normal_move(board, board_pos)
      end
      change_player_turn(board)
    end

    def pawn_move(board, board_pos)
      if en_passant?(board, board_pos)
        play_en_passant(board, board_pos)
      elsif pawn_promotion?(board, board_pos)
        play_pawn_promotion(board, board_pos)
      else
        play_normal_move(board, board_pos)
      end
    end

    def pawn_promotion?(_board, _board_pos)
      true
    end

    def en_passant?(_board, _board_pos)
      true
    end

    def play_en_passant(board, board_pos)
      # TODO: implement en passant
      play_normal_move(board, board_pos)
    end

    def play_pawn_promotion(board, board_pos)
      # TODO: implement pawn promotion
      play_normal_move(board, board_pos)
    end

    def play_normal_move(board, board_pos)
      board.remove_piece_at(board_pos)
      board.insert_piece_at(@selected_piece, board_pos)
      board.remove_piece_at(@selected_piece_pos)
    end
  end
end
