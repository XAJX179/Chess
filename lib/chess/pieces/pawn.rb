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

      # possible_moves of the pawn
      # @example x and y are decomposed from array
      #   possible_moves(board,['a',2])
      # @param board [Chess::Board]
      # @return [Array] moves
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

      # checks if it's first move of pawn
      # @param rank [Integer]
      # @return [Boolean]
      def first_move?(rank)
        (rank == 2 && white?) || (rank == 7 && black?)
      end

      # creates all the possible first moves
      # @param board [Chess::Board]
      # @param file [String]
      # @param rank [Integer]
      # @return [Array] moves
      def first_moves(board, file, rank)
        moves = []
        moves + one_step_forward(board, file, rank)
        # moves + two_step_forward(board, file, rank)
      end

      # one step move of pawn
      # @param board [Chess::Board]
      # @param file [String]
      # @param rank [Integer]
      # @return [Array] moves
      def one_step_forward(board, file, rank)
        moves = []
        if white?
          north = board.north_pos(file, rank)
          moves << north if board.empty_at?(*north)
        else
          south = board.south_pos(file, rank)
          moves << south if board.empty_at?(*south)
        end
        moves
      end

      # two step move of pawn
      # @param board [Chess::Board]
      # @param file [String]
      # @param rank [Integer]
      # @return [Array] moves
      def two_step_forward(board, file, rank)
        # TODO: implement blocking piece in between and en passant
      end
    end
  end
end
