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

      def possible_moves(board, (file, rank))
        moves = []
        if first_move?(rank)
          pp 'first_move'
          moves += first_moves(board, file, rank)
        else
          pp 'not first move'
          moves += other_moves
        end
        moves
      end

      def first_move?(rank)
        (rank == 2 && @color == 'white') || (rank == 7 && @color == 'black')
      end

      def first_moves(board, file, rank)
        moves = []
        moves + one_step_forward(board, file, rank)
      end

      def one_step_forward(board, file, rank)
        moves = []
        if @color == 'white'
          north = board.north_pos(file, rank)
          piece = board.piece_at(*north)
          moves << north if piece != '' || !piece.nil?
        else
          south = board.south_pos(file, rank)
          moves << south if piece != '' || !piece.nil?
        end
      end
    end
  end
end
