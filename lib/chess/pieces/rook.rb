# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # RookMoves
    module RookMoves
      def north_moves(board, file, rank)
        north = board.north_pos(file, rank)

        moves = []
        while board.empty_at?(*north)
          moves << north if board.pos_in_range?(north)
          north = board.north_pos(*north)
          pp moves
        end
        moves << north if board.pos_in_range?(north) && board.enemy_at?(*north)
        moves
      end

      def south_moves(board, file, rank)
        south = board.south_pos(file, rank)

        moves = []
        while board.empty_at?(*south)
          moves << south if board.pos_in_range?(south)
          south = board.south_pos(*south)
          pp moves
        end
        moves << south if board.pos_in_range?(south) && board.enemy_at?(*south)
        moves
      end

      def east_moves(board, file, rank)
        east = board.east_pos(file, rank)

        moves = []
        while board.empty_at?(*east)
          moves << east if board.pos_in_range?(east)
          east = board.east_pos(*east)
          pp moves
        end
        moves << east if board.pos_in_range?(east) && board.enemy_at?(*east)
        moves
      end

      def west_moves(board, file, rank)
        west = board.west_pos(file, rank)

        moves = []
        while board.empty_at?(*west)
          moves << west if board.pos_in_range?(west)
          west = board.west_pos(*west)
          pp moves
        end
        moves << west if board.pos_in_range?(west) && board.enemy_at?(*west)
        moves
      end
    end

    # Rook
    class Rook < Piece
      include RookMoves

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
    end
  end
end
