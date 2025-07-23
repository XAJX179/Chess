# frozen_string_literal: true

# Chess
module Chess
  # Player
  class Player
    include PlayMovesByType

    attr_accessor :selected_piece

    def initialize
      @selected_piece = ''
    end

    # select a move
    # @param board [Chess::Board]
    # @param board_pos [Array]
    def select_move(board, board_pos)
      pp board_pos
      # TODO: implement select_move
      if @selected_piece.valid_moves.include?(board_pos)
        pp 'valid move'
        play_move_by_type(board, board_pos)
      else
        pp 'invalid move'
      end
      @selected_piece
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
