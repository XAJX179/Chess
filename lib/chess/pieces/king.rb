# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # King
    class King < Piece
      attr_reader :in_check

      def possible_moves(board)
        return [] if board.current_player != @color.chr

        file = @pos[0]
        rank = @pos[1]
        moves = []
        moves += one_step_all_direction_moves(board, file, rank)
        moves += castling_moves(board, file, rank)
        moves
      end

      def one_step_all_direction_moves(board, file, rank)
        north = board.north_pos(file, rank)
        south = board.south_pos(file, rank)
        west = board.west_pos(file, rank)
        east = board.east_pos(file, rank)
        north_west = board.north_west_pos(file, rank)
        south_east = board.south_east_pos(file, rank)
        south_west = board.south_west_pos(file, rank)
        north_east = board.north_east_pos(file, rank)
        directions = north, south, west, east, north_west, south_east, south_west, north_east

        get_moves_on_direction(board, directions)
      end

      def get_moves_on_direction(board, directions)
        moves = []
        directions.each do |direction|
          if board.pos_in_range?(direction) && (board.empty_at?(*direction) || board.enemy_at?(*direction))
            moves << direction
          end
        end
        moves
      end

      def castling_moves(_board, _file, _rank)
        []
      end

      def in_check?(board, opponent_pieces)
        # TODO: implement condition for when in check
        @in_check = false
        opponent_pieces.each do |piece|
          break if @in_check

          possible_moves = piece.possible_moves(board)
          @in_check = true if possible_moves.include?(@pos)
        end
        @in_check
      end
    end
  end
end
