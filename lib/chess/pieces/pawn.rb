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
        moves += pawn_moves_by_color(board, file, rank)
        moves
      end

      # checks if it's first move of pawn
      # @param rank [Integer]
      def first_move?(rank)
        (rank == 1 && white?) || (rank == 6 && black?)
      end

      # creates all the possible first moves
      # @param board [Chess::Board]
      # @param file [String]
      # @param rank [Integer]
      # @return [Array] moves
      def pawn_moves_by_color(board, file, rank)
        moves = []
        moves += one_step_forward(board, file, rank)
        moves += two_step_forward(board, file, rank) if first_move?(rank)
        moves += attack_en_passant(board, file, rank) unless first_move?(rank)
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
          moves << south if board.empty_at?(*south) && board.pos_in_range?(south)
        end
        moves
      end

      # two step move of pawn
      # @param board [Chess::Board]
      # @param file [String]
      # @param rank [Integer]
      # @return [Array] moves
      def two_step_forward(board, file, rank)
        moves = []
        moves << if white?
                   north_two_step(board, file, rank)
                 else
                   south_two_step(board, file, rank)
                 end
        moves
      end

      # helper method for {#two_step_forward}
      # @param (see #two_step_forward)
      # @return (see #two_step_forward)
      def north_two_step(board, file, rank)
        north_one_step = board.north_pos(file, rank)
        north_two_step = board.north_pos(*north_one_step)
        return [] unless board.empty_at?(*north_one_step) && board.empty_at?(*north_two_step)

        north_two_step
      end

      # helper method for {#two_step_forward}
      # @param (see #two_step_forward)
      # @return (see #two_step_forward)
      def south_two_step(board, file, rank)
        south_one_step = board.south_pos(file, rank)
        south_two_step = board.south_pos(*south_one_step)
        unless board.empty_at?(*south_one_step) && board.empty_at?(*south_two_step) &&
               board.pos_in_range?(south_one_step) && board.pos_in_range?(south_two_step)

          return []
        end

        south_two_step
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

      # helper method for {#cross_side_attack}
      # @param (see #cross_side_attack)
      # @return (see #cross_side_attack)
      def north_attack(board, file, rank)
        moves = []
        north_east = board.north_east_pos(file, rank)
        north_west = board.north_west_pos(file, rank)
        [north_east, north_west].each do |pos|
          moves << pos if !(board.empty_at?(*pos) || board.pos_nil?(pos)) && board.piece_at(*pos).black?
        end
        moves
      end

      # helper method for {#cross_side_attack}
      # @param (see #cross_side_attack)
      # @return (see #cross_side_attack)
      def south_attack(board, file, rank)
        moves = []
        south_east = board.south_east_pos(file, rank)
        south_west = board.south_west_pos(file, rank)
        [south_east, south_west].each do |pos|
          moves << pos if !(board.empty_at?(*pos) || board.pos_nil?(pos)) &&
                          board.piece_at(*pos).white? &&
                          board.pos_in_range?(pos)
        end
        moves
      end

      # moves for attacking an pawn which is a {Chess::Board#possible_en_passant_target}
      #
      # @param (see #cross_side_attack)
      # @return (see #cross_side_attack)
      def attack_en_passant(board, file, rank) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        moves = []
        if white?
          north_east = board.north_east_pos(file, rank)
          moves << north_east if (north_east.first + north_east.last.to_s) == board.possible_en_passant_target
          north_west = board.north_west_pos(file, rank)
          moves << north_west if (north_west.first + north_west.last.to_s) == board.possible_en_passant_target
        else
          south_east = board.south_east_pos(file, rank)
          moves << south_east if (south_east.first + south_east.last.to_s) == board.possible_en_passant_target
          south_west = board.south_west_pos(file, rank)
          moves << south_west if (south_west.first + south_west.last.to_s) == board.possible_en_passant_target
        end
        moves
      end
    end
  end
end
