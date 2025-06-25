# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # Pawn
    class Pawn < Piece
      def test
        puts 'hello world'
      end

      def valid_moves(board, (file, rank))
        # TODO: implement en passant attack
      end
    end
  end
end
