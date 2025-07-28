# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # Knight
    class Knight < Piece
      def possible_moves(board)
        return [] if board.current_player != @color.chr

        file = @pos[0]
        rank = @pos[1]
        moves = []
        moves += north_moves(board, file, rank)
        moves += south_moves(board, file, rank)
        moves += west_moves(board, file, rank)
        moves += east_moves(board, file, rank)
        moves
      end

      def north_moves(board, file, rank)
        moves = []
        north_steps = 2
        two_step_north = [file, rank + north_steps]

        east = board.east_pos(*two_step_north)
        west = board.west_pos(*two_step_north)
        moves << east if board.pos_in_range?(east) && (board.empty_at?(*east) || board.enemy_at?(*east))
        moves << west if board.pos_in_range?(west) && (board.empty_at?(*west) || board.enemy_at?(*west))
        moves
      end

      def south_moves(board, file, rank)
        moves = []
        south_steps = 2
        two_step_south = [file, rank - south_steps]

        return moves unless board.pos_in_range?(two_step_south)

        east = board.east_pos(*two_step_south)
        west = board.west_pos(*two_step_south)
        [east, west].each do |pos|
          moves << pos if board.pos_in_range?(pos) && (board.empty_at?(*pos) || board.enemy_at?(*pos))
        end
        moves
      end

      def west_moves(board, file, rank)
        moves = []
        west_steps = 2
        two_step_west = [(file.ord - west_steps).chr, rank]

        return moves unless board.pos_in_range?(two_step_west)

        north = board.north_pos(*two_step_west)
        south = board.south_pos(*two_step_west)
        [north, south].each do |pos|
          moves << pos if board.pos_in_range?(pos) && (board.empty_at?(*pos) || board.enemy_at?(*pos))
        end
        moves
      end

      def east_moves(board, file, rank)
        moves = []
        east_steps = 2
        two_step_east = [(file.ord + east_steps).chr, rank]
        north = board.north_pos(*two_step_east)
        south = board.south_pos(*two_step_east)
        [north, south].each do |pos|
          moves << pos if board.pos_in_range?(pos) && (board.empty_at?(*pos) || board.enemy_at?(*pos))
        end
        moves
      end
    end
  end
end
