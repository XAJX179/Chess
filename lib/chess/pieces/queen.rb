# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # Queen
    class Queen < Piece
      include RookMoves
      include BishopMoves

      # all possible_moves of Queen
      #
      # @param board [Chess::Board]
      # @return [Array] possible_moves_arr
      def possible_moves(board)
        file = @pos[0]
        rank = @pos[1]
        moves = []
        moves += rook_moves(board, file, rank)
        moves += bishop_moves(board, file, rank)
        moves
      end

      def rook_moves(board, file, rank)
        moves = []
        moves += north_moves(board, file, rank)
        moves += south_moves(board, file, rank)
        moves += west_moves(board, file, rank)
        moves += east_moves(board, file, rank)
        moves
      end

      def bishop_moves(board, file, rank)
        moves = []
        moves += north_west_moves(board, file, rank)
        moves += north_east_moves(board, file, rank)
        moves += south_west_moves(board, file, rank)
        moves += south_east_moves(board, file, rank)
        moves
      end
    end
  end
end
