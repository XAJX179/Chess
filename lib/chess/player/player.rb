# frozen_string_literal: true

# Chess
module Chess
  # Player
  class Player
    include PlayMovesByType

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
      valid_moves = @selected_piece.valid_moves(board, @selected_piece_pos)
      if valid_moves.include?(board_pos)
        pp 'valid move'
        play_move_by_type(board, board_pos)
      else
        pp 'invalid move'
      end
      puts "selected_piece_pos => #{@selected_piece_pos}"
    end

    def change_player_turn(board)
      current_player_color = board.current_player
      board.current_player = if current_player_color == 'w'
                               'b'
                             else
                               'w'
                             end
    end
  end
end
