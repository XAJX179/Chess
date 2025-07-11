# frozen_string_literal: true

# Chess
module Chess
  # Player
  class Player
    attr_accessor :selected_piece, :selected_piece_pos

    def initialize
      @selected_piece = ''
      @selected_piece_pos = ''
    end

    # select a move
    # @param board [Chess::Board]
    # @param board_pos [Array]
    def select_move(board, board_pos)
      pp board_pos
      # TODO: implement select_move
      possible_moves = @selected_piece.possible_moves(board, @selected_piece_pos)
      # valid_moves = @selected_piece.valid_moves(board, possible_moves, @selected_piece_pos)
      # if valid_moves.include?(board_pos)
      #   pp 'valid move'
      # else
      #   pp 'invalid move'
      # end
      puts "selected_piece_pos => #{@selected_piece_pos}"
      puts "possible_moves => #{possible_moves}"
    end
  end
end
