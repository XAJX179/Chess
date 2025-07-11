# frozen_string_literal: true

# Chess
module Chess
  # Game class
  class Game
    include Display
    include Mouse
    include Save

    def initialize(player = Chess::Player)
      @white_player = player.new
      @black_player = player.new
    end

    # select different actions based on what was clicked
    # @param board [Chess::Board]
    # @param clicked [String]
    # @param board_pos [Array]
    # @param mouse_coord [Array]
    # return [void]
    def select_click_action(board, clicked, board_pos, mouse_coord)
      return if clicked == 'outside'

      if clicked == 'board'
        board_action(board, board_pos)
      else
        button_action(mouse_coord)
      end
    end

    # actions for clicks on board
    # @param board [Chess:Board]
    # @param board_pos [Array]
    def board_action(board, board_pos)
      player = if board.current_player == 'w'
                 @white_player
               else
                 @black_player
               end
      valid_moves = player_turn(player, board, board_pos)
      redraw_display(board.data, valid_moves)
    end

    # actions for clicks on buttons
    # @param mouse_coord [Array]
    def button_action(mouse_coord)
      type = button_type(mouse_coord)
      if type == 'save&exit'
        save_and_exit
      else
        exit
      end
    end

    # player turn to select move
    # @param player [Chess::Player]
    # @param board [Chess::Board]
    # @param board_pos [Array]
    def player_turn(player, board, board_pos)
      if player.selected_piece == ''
        player.selected_piece = board.piece_at(*board_pos)
        valid_moves = player.selected_piece.valid_moves(board, board_pos) unless player.selected_piece == ''
        player.selected_piece_pos = board_pos
        valid_moves || []
      else
        player.select_move(board, board_pos)
        player.selected_piece = ''
        []
      end
    end

    # exits the game.
    def exit
      pp 'exit'
      # TODO: implement exit
    end

    # save and exit the game.
    def save_and_exit
      pp 'save_and_exit'
      # TODO: implement save and exit
    end
  end
end
