# frozen_string_literal: true

# Chess
module Chess
  # PawnMoves
  module PlayPawnMoves
    include Display

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

    def move_two_step(piece, board, move_pos)
      play_normal_move(piece, board, move_pos)
      set_board_possible_en_passant(piece, board)
      @remove_en_passant = false
    end

    def attacking_en_passant?(piece, board, move_pos)
      file = piece.pos.first
      rank = piece.pos.last
      moves = piece.attack_en_passant(board, file, rank)
      moves.include?(move_pos)
    end

    def pawn_is_promoting?(piece)
      rank = piece.pos.last
      return true if rank == 1 && piece.black?

      true if rank == 6 && piece.white?
    end

    def pawn_two_step_move?(piece, board, move_pos)
      file = piece.pos.first
      rank = piece.pos.last
      moves = piece.two_step_forward(board, file, rank)
      moves.include?(move_pos)
    end

    def remove_enemy_en_passant_pawn(piece, board, move_pos)
      file = move_pos.first
      rank = if piece.white?
               move_pos.last - 1
             else
               move_pos.last + 1
             end
      board.remove_piece_at([file, rank])
    end

    def set_board_possible_en_passant(piece, board)
      file = piece.pos.first
      rank = if piece.white?
               piece.pos.last - 1
             else
               piece.pos.last + 1
             end
      board.possible_en_passant_target = file + rank.to_s
    end

    def remove_en_passant_from_board(board)
      board.possible_en_passant_target = ''
    end

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
