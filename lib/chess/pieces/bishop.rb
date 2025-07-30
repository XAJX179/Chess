# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # BishopMoves
    module BishopMoves
      def north_west_moves(board, file, rank)
        north_west = board.north_west_pos(file, rank)

        moves = []
        while board.empty_at?(*north_west)
          moves << north_west if board.pos_in_range?(north_west)
          north_west = board.north_west_pos(*north_west)
          pp moves
        end
        moves << north_west if board.pos_in_range?(north_west) && board.enemy_at?(*north_west)
        moves
      end

      def south_west_moves(board, file, rank)
        south_west = board.south_west_pos(file, rank)

        moves = []
        while board.empty_at?(*south_west)
          moves << south_west if board.pos_in_range?(south_west)
          south_west = board.south_west_pos(*south_west)
          pp moves
        end
        moves << south_west if board.pos_in_range?(south_west) && board.enemy_at?(*south_west)
        moves
      end

      def north_east_moves(board, file, rank)
        north_east = board.north_east_pos(file, rank)

        moves = []
        while board.empty_at?(*north_east)
          moves << north_east if board.pos_in_range?(north_east)
          north_east = board.north_east_pos(*north_east)
          pp moves
        end
        moves << north_east if board.pos_in_range?(north_east) && board.enemy_at?(*north_east)
        moves
      end

      def south_east_moves(board, file, rank)
        south_east = board.south_east_pos(file, rank)

        moves = []
        while board.empty_at?(*south_east)
          moves << south_east if board.pos_in_range?(south_east)
          south_east = board.south_east_pos(*south_east)
          pp moves
        end
        moves << south_east if board.pos_in_range?(south_east) && board.enemy_at?(*south_east)
        moves
      end
    end

    # Bishop
    class Bishop < Piece
      include BishopMoves

      def possible_moves(board)
        return [] if board.current_player != @color.chr

        file = @pos[0]
        rank = @pos[1]
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
