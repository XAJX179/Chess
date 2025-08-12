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
      update_king_status(board)
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
        select_piece(piece, player, board)
      else
        select_move(player, board, board_pos)
        []
      end
    end

    def select_piece(piece, player, board)
      player.selected_piece = piece if same_color?(board.current_player, piece)
      if player.selected_piece == ''
        []
      else
        player.selected_piece.valid_moves = valid_moves(piece, board)
      end
    end

    def select_move(player, board, move_pos)
      player.select_move(board, move_pos)
      player.selected_piece.valid_moves = []
      player.selected_piece = ''
    end

    def valid_moves(piece, board)
      possible_moves = piece.possible_moves(board)
      new_player = Player.new

      fen_code = generate_fen_code(board)
      valid_moves_from_possible_moves(piece, possible_moves, fen_code, new_player)
    end

    def valid_moves_from_possible_moves(piece, possible_moves, fen_code, new_player)
      valid_moves_arr = []
      possible_moves.each do |move|
        new_board = Chess::Board.new(fen_code)
        new_player.selected_piece = new_board.piece_at(*piece.pos)
        new_player.play_move_by_type(new_player.selected_piece, new_board, move, inside_valid_moves_flag: true)
        in_check = king_comes_in_check?(piece, new_board)

        valid_moves_arr << move unless in_check
      end
      valid_moves_arr
    end

    def king_comes_in_check?(piece, new_board)
      if piece.white?
        new_board.white_king.in_check?(new_board, new_board.black_pieces)
      else
        new_board.black_king.in_check?(new_board, new_board.white_pieces)
      end
    end

    def same_color?(current_player, piece)
      piece.color.chr == current_player unless piece == ''
    end

    def update_king_status(board)
      current_player = board.current_player
      board.current_player = 'b'
      board.white_king.in_check?(board, board.black_pieces)
      board.current_player = 'w'
      board.black_king.in_check?(board, board.white_pieces)
      board.current_player = current_player
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
