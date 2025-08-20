# frozen_string_literal: true

# Chess
module Chess
  # ValidMoves
  module ValidMoves
    def valid_moves(piece, board)
      possible_moves = piece.possible_moves(board)
      new_player = Player.new
      fen_code = generate_fen_code(board)

      if piece.is_a?(Pieces::King)
        valid_moves_for_king(board, piece, possible_moves, fen_code, new_player)
      else
        valid_moves_from_possible_moves(piece, possible_moves, fen_code, new_player)
      end
    end

    def valid_moves_from_possible_moves(piece, possible_moves, fen_code, new_player)
      valid_moves_arr = []
      possible_moves.each do |move|
        invalid = invalid_normal_move?(move, piece, fen_code, new_player)
        valid_moves_arr << move unless invalid
      end
      valid_moves_arr
    end

    def invalid_normal_move?(move, piece, fen_code, new_player)
      new_board = Chess::Board.new(fen_code)
      new_player.selected_piece = new_board.piece_at(*piece.pos)
      new_player.play_move_by_type(new_player.selected_piece, new_board, move, inside_valid_moves_flag: true)
      king_comes_in_check?(piece, new_board)
    end

    def valid_moves_for_king(board, piece, possible_moves, fen_code, new_player) # rubocop:disable Metrics/MethodLength
      valid_moves_arr = []
      castling_moves = piece.castling_moves(board)
      invalid = false
      possible_moves.each do |move|
        invalid = if castling_moves.include?(move)
                    invalid_castling_move?(move, piece, fen_code, new_player)
                  else
                    invalid_normal_move?(move, piece, fen_code, new_player)
                  end
        valid_moves_arr << move unless invalid
      end
      valid_moves_arr
    end

    def invalid_castling_move?(move, piece, fen_code, new_player)
      return true if piece.in_check

      file = move.first
      if file.downcase == 'c'
        invalid_queen_side_castle?(move, piece, fen_code, new_player)
      elsif file.downcase == 'g'
        invalid_king_side_castle?(move, piece, fen_code, new_player)
      end
    end

    def invalid_queen_side_castle?(move, piece, fen_code, new_player)
      comes_in_check = castling_king_passes_check?(move, piece, fen_code, new_player)
      move = ['d', move.last]
      passes_check = castling_king_passes_check?(move, piece, fen_code, new_player)
      passes_check || comes_in_check
    end

    def invalid_king_side_castle?(move, piece, fen_code, new_player)
      comes_in_check = castling_king_passes_check?(move, piece, fen_code, new_player)
      move = ['f', move.last]
      passes_check = castling_king_passes_check?(move, piece, fen_code, new_player)
      passes_check || comes_in_check
    end

    def castling_king_passes_check?(move, piece, fen_code, new_player)
      new_board = Chess::Board.new(fen_code)
      new_player.selected_piece = new_board.piece_at(*piece.pos)
      new_player.play_move_by_type(new_player.selected_piece, new_board, move, inside_valid_moves_flag: true)
      king_comes_in_check?(piece, new_board)
    end

    def king_comes_in_check?(piece, new_board)
      if piece.white?
        new_board.white_king.in_check?(new_board, new_board.black_pieces)
      else
        new_board.black_king.in_check?(new_board, new_board.white_pieces)
      end
    end
  end
end
