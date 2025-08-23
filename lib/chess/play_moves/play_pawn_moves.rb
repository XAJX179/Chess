# frozen_string_literal: true

# Chess
module Chess
  # PawnMoves
  module PlayPawnMoves
    include Display

    # play appropriate type of pawn move
    #
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param board [Chess::Board]
    # @param move_pos [Array]
    # @param inside_valid_moves_flag [Boolean]
    # @return [void]
    def play_pawn_move(piece, board, move_pos, inside_valid_moves_flag)
      if pawn_is_promoting?(piece)
        play_pawn_promotion(piece, board, move_pos, inside_valid_moves_flag)
      elsif attacking_en_passant?(piece, board, move_pos)
        play_normal_move(piece, board, move_pos)
        remove_enemy_en_passant_pawn(piece, board, move_pos)
      elsif pawn_two_step_move?(piece, board, move_pos)
        move_two_step(piece, board, move_pos)
      else
        play_normal_move(piece, board, move_pos)
      end
    end

    # play two step move
    #
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param board [Chess::Board]
    # @param move_pos [Array]
    # @return [void]
    def move_two_step(piece, board, move_pos)
      play_normal_move(piece, board, move_pos)
      set_board_possible_en_passant(piece, board)
      @remove_en_passant = false
    end

    # check if move is attacking a enemy pawn at {Chess::Board#possible_en_passant_target}
    # @param (see #move_two_step)
    def attacking_en_passant?(piece, board, move_pos)
      file = piece.pos.first
      rank = piece.pos.last
      moves = piece.attack_en_passant(board, file, rank)
      moves.include?(move_pos)
    end

    # check if pawn is promoting
    # @param piece any subclass of {Chess::Pieces::Piece}
    def pawn_is_promoting?(piece)
      rank = piece.pos.last
      return true if rank == 1 && piece.black?

      true if rank == 6 && piece.white?
    end

    # check if moving two step
    #
    # @param (see #move_two_step)
    def pawn_two_step_move?(piece, board, move_pos)
      file = piece.pos.first
      rank = piece.pos.last
      moves = piece.two_step_forward(board, file, rank)
      moves.include?(move_pos)
    end

    # remove enemy pawn in attacking en passant
    # @param (see #move_two_step)
    # @return [void]
    def remove_enemy_en_passant_pawn(piece, board, move_pos)
      file = move_pos.first
      rank = if piece.white?
               move_pos.last - 1
             else
               move_pos.last + 1
             end
      board.remove_piece_at([file, rank])
    end

    # set board possible_en_passant_target
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param board [Chess::Board]
    # @return [void]
    def set_board_possible_en_passant(piece, board)
      file = piece.pos.first
      rank = if piece.white?
               piece.pos.last - 1
             else
               piece.pos.last + 1
             end
      board.possible_en_passant_target = file + rank.to_s
    end

    # remove possible_en_passant_target pos from board
    # @param board [Chess::Board]
    # @return [void]
    def remove_en_passant_from_board(board)
      board.possible_en_passant_target = ''
    end

    # play pawn promotion move
    # @param (see #play_pawn_move)
    # @return [void]
    def play_pawn_promotion(piece, board, move_pos, inside_valid_moves_flag)
      board.remove_piece_at(piece.pos)
      new_piece_letter = 'q'
      new_piece_letter = prompt_pawn_promotion_choices unless inside_valid_moves_flag
      new_piece_letter = new_piece_letter.upcase if piece.white?
      piece = board.create_piece(new_piece_letter)
      board.insert_piece_at(piece, move_pos)
    end
  end
end
