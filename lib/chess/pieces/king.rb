# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # King
    class King < Piece
      include Chess::Save::FenCodeFromBoard

      attr_accessor :in_check

      def initialize(color)
        super
        @in_check = false
      end

      def possible_moves(board)
        file = @pos[0]
        rank = @pos[1]
        moves = []
        moves += one_step_all_direction_moves(board, file, rank)
        moves += castling_moves(board)
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

      def castling_moves(board)
        moves = []
        if valid_castling_rights?(board)
          if white?
            moves += white_castling_moves(board)
          elsif black?
            moves += black_castling_moves(board)
          end
        end
        moves
      end

      def valid_castling_rights?(board)
        return false if board.castling_rights == '-'

        board.castling_rights.include?('K') ||
          board.castling_rights.include?('Q') ||
          board.castling_rights.include?('k') ||
          board.castling_rights.include?('q')
      end

      def white_castling_moves(board)
        moves = []
        moves << ['g', 0] if board.castling_rights.include?('K') && can_castle?(board, 'K')
        moves << ['c', 0] if board.castling_rights.include?('Q') && can_castle?(board, 'Q')
        moves
      end

      def black_castling_moves(board)
        moves = []
        moves << ['g', 7] if board.castling_rights.include?('k') && can_castle?(board, 'k')
        moves << ['c', 7] if board.castling_rights.include?('q') && can_castle?(board, 'q')
        moves
      end

      def can_castle?(board, castling_right)
        case castling_right
        when 'Q'
          no_piece_in_between?(board, ['a', 0], ['e', 0])
        when 'K'
          no_piece_in_between?(board, ['e', 0], ['h', 0])
        when 'q'
          no_piece_in_between?(board, ['a', 7], ['e', 7])
        when 'k'
          no_piece_in_between?(board, ['e', 7], ['h', 7])
        end
      end

      def no_piece_in_between?(board, start, finish)
        curr_file = start.first
        rank = start.last
        pieces = []
        loop do
          curr_file = (curr_file.ord + 1).chr
          break if curr_file == finish.first

          pieces << board.piece_at(curr_file, rank)
        end
        pieces.all?('')
      end

      def in_check?(board, opponent_pieces)
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
