# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # Pawn
    class Pawn < Piece
      # possible_moves of the pawn
      # @param board [Chess::Board]
      # @return [Array] moves
      def possible_moves(board)
        moves = []
        file = @pos[0]
        rank = @pos[1]
        moves += if first_move?(rank)
                   first_moves(board, file, rank)
                 else
                   other_moves(board, file, rank)
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
        moves += two_step_forward(board, file, rank)
        moves += cross_side_attack(board, file, rank)
        moves.reject!(&:empty?)
        moves
      end

      def other_moves(board, file, rank)
        moves = []
        moves += one_step_forward(board, file, rank)
        moves += cross_side_attack(board, file, rank)
        moves.reject!(&:empty?)
        moves
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
          moves << south if board.empty_at?(*south) && board.pos_rank_in_range?(south)
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
        moves
      end

      def north_two_step(board, file, rank)
        north_one_step = board.north_pos(file, rank)
        north_two_step = board.north_pos(*north_one_step)
        return [] unless board.empty_at?(*north_one_step) && board.empty_at?(*north_two_step)

        set_en_passant_target(board, file, rank)
        north_two_step
      end

      def south_two_step(board, file, rank)
        south_one_step = board.south_pos(file, rank)
        south_two_step = board.south_pos(*south_one_step)
        unless board.empty_at?(*south_one_step) && board.empty_at?(*south_two_step) &&
               board.pos_rank_in_range?(south_one_step) && board.pos_rank_in_range?(south_two_step)

          return []
        end

        set_en_passant_target(board, file, rank)
        south_two_step
      end

      def set_en_passant_target(board, file, rank)
        board.possible_en_passant_target = file + rank.to_s
      end

      # cross attack moves of pawn
      # @param board [Chess::Board]
      # @param file [String]
      # @param rank [Integer]
      # @return [Array] moves
      def cross_side_attack(board, file, rank)
        moves = []
        moves += if white?
                   north_attack(board, file, rank)
                 else
                   south_attack(board, file, rank)
                 end
        moves
      end

      def north_attack(board, file, rank)
        moves = []
        north_east = board.north_east_pos(file, rank)
        north_west = board.north_west_pos(file, rank)
        [north_east, north_west].each do |pos|
          moves << pos if !(board.empty_at?(*pos) || board.pos_nil?(pos)) && board.piece_at(*pos).black?
        end
        moves
      end

      def south_attack(board, file, rank)
        moves = []
        south_east = board.south_east_pos(file, rank)
        south_west = board.south_west_pos(file, rank)
        [south_east, south_west].each do |pos|
          moves << pos if !(board.empty_at?(*pos) || board.pos_nil?(pos)) &&
                          board.piece_at(*pos).white? &&
                          board.pos_rank_in_range?(pos)
        end
        moves
      end
    end
  end
end
