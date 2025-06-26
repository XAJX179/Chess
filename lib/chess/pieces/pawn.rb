# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # Pawn
    class Pawn < Piece
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
        moves += one_step_forward(board, file, rank)
        moves + two_step_forward(board, file, rank)
        # moves + cross_side_attack(board, file, rank)
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
        # TODO: implement en passant
        moves = []
        moves << if white?
                   north_two_step(board, file, rank)
                 else
                   south_two_step(board, file, rank)
                 end
      end

      def north_two_step(board, file, rank)
        moves = []
        north_one_step = board.north_pos(file, rank)
        north_two_step = board.north_pos(*north_one_step)
        return unless board.empty_at?(*north_one_step) && board.empty_at?(*north_two_step)

        set_en_passant_target(board, file, rank)
        moves << north_two_step
      end

      def south_two_step(board, file, rank)
        moves = []
        south_one_step = board.south_pos(file, rank)
        south_two_step = board.south_pos(*south_one_step)
        return unless board.empty_at?(*south_one_step) && board.empty_at?(*south_two_step)

        set_en_passant_target(board, file, rank)
        moves << south_two_step
      end

      def set_en_passant_target(board, file, rank)
        board.possible_en_passant_target = file + rank.to_s
      end

      # cross attack moves of pawn
      # @param board [Chess::Board]
      # @param file [String]
      # @param rank [Integer]
      # @return [Array] moves
      def cross_side_attack(_board, _file, _rank)
        []
      end
    end
  end
end
