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
      pp board_pos
      pp player
      gets
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
      piece = board.piece_at(*board_pos)
      if player.selected_piece == '' || same_color?(board.current_player, piece)
        select_piece(player, board, board_pos)
      else
        select_move(player, board, board_pos)
      end
    end

    def select_piece(player, board, board_pos)
      piece = board.piece_at(*board_pos)
      player.selected_piece = piece if same_color?(board.current_player, piece)
      if player.selected_piece == ''
        []
      else
        player.selected_piece.pos = board_pos
        player.selected_piece.valid_moves = selected_piece_valid_moves(piece, board, board_pos)
      end
    end

    def select_move(player, board, board_pos)
      player.select_move(board, board_pos)
      player.selected_piece.valid_moves = []
      player.selected_piece = ''
      []
    end

    def selected_piece_valid_moves(piece, board, board_pos)
      # TODO: implement valid_moves out of possible_moves
      possible_moves = piece.possible_moves(board, board_pos)
      legal_moves(piece, possible_moves, board, board_pos)
      possible_moves
    end

    def legal_moves(_piece, _possible_moves, _board, _board_pos)
      legal_moves = []
      pp legal_moves
    end

    def same_color?(current_player, piece)
      piece.color.chr == current_player unless piece == ''
    end

    # save the game
    def save
      pp 'save'
      # TODO: implement save
    end

    # exits the game
    def exit
      pp 'exit'
      # TODO: implement exit
    end

    # save and exit the game
    def save_and_exit
      pp 'save_and_exit'
      # TODO: implement save and exit
    end
  end
end
