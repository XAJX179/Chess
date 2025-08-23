# frozen_string_literal: true

# Chess
module Chess
  # ValidMoves
  module ValidMoves
    # find valid_moves for given piece on the given board
    #
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param board [Chess::Board]
    # @return [Array] valid_moves_arr
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

    # find valid_moves from possible_moves
    #
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param possible_moves [Array]
    # @param fen_code [String]
    # @param new_player [Chess::Player]
    # @return [Array] valid_moves_arr
    def valid_moves_from_possible_moves(piece, possible_moves, fen_code, new_player)
      valid_moves_arr = []
      possible_moves.each do |move|
        invalid = invalid_normal_move?(move, piece, fen_code, new_player)
        valid_moves_arr << move unless invalid
      end
      valid_moves_arr
    end

    # check if given move is invalid
    #
    # @param move [Array]
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param fen_code [String]
    # @param new_player [Chess::Player]
    def invalid_normal_move?(move, piece, fen_code, new_player)
      new_board = Chess::Board.new(fen_code)
      new_player.selected_piece = new_board.piece_at(*piece.pos)
      new_player.play_move_by_type(new_player.selected_piece, new_board, move, inside_valid_moves_flag: true)
      king_comes_in_check?(piece, new_board)
    end

    # find valid_moves for given king on the given board
    #
    # @param board [Chess::Board]
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param possible_moves [Array]
    # @param fen_code [String]
    # @param new_player [Chess::Player]
    # @return [Array] valid_moves_arr
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

    # Check if given castling move is invalid
    #
    # @param move [Array]
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param fen_code [String]
    # @param new_player [Chess::Player]
    def invalid_castling_move?(move, piece, fen_code, new_player)
      return true if piece.in_check

      file = move.first
      if file.downcase == 'c'
        invalid_queen_side_castle?(move, piece, fen_code, new_player)
      elsif file.downcase == 'g'
        invalid_king_side_castle?(move, piece, fen_code, new_player)
      end
    end

    # helper method for {#invalid_castling_move?}
    # @param (see #invalid_castling_move?)
    def invalid_queen_side_castle?(move, piece, fen_code, new_player)
      comes_in_check = castling_king_passes_check?(move, piece, fen_code, new_player)
      move = ['d', move.last]
      passes_check = castling_king_passes_check?(move, piece, fen_code, new_player)
      passes_check || comes_in_check
    end

    # helper method for {#invalid_castling_move?}
    # @param (see #invalid_castling_move?)
    def invalid_king_side_castle?(move, piece, fen_code, new_player)
      comes_in_check = castling_king_passes_check?(move, piece, fen_code, new_player)
      move = ['f', move.last]
      passes_check = castling_king_passes_check?(move, piece, fen_code, new_player)
      passes_check || comes_in_check
    end

    # helper method for {#invalid_castling_move?}
    # @param (see #invalid_castling_move?)
    def castling_king_passes_check?(move, piece, fen_code, new_player)
      new_board = Chess::Board.new(fen_code)
      new_player.selected_piece = new_board.piece_at(*piece.pos)
      new_player.play_move_by_type(new_player.selected_piece, new_board, move, inside_valid_moves_flag: true)
      king_comes_in_check?(piece, new_board)
    end

    # Checks if king comes in check
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param new_board new board obj of [Chess::Board]
    def king_comes_in_check?(piece, new_board)
      if piece.white?
        new_board.white_king.in_check?(new_board, new_board.black_pieces)
      else
        new_board.black_king.in_check?(new_board, new_board.white_pieces)
      end
    end
  end
end
