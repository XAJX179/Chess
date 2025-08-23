# frozen_string_literal: true

# Chess
module Chess
  # Game class
  class Game
    include Display
    include Mouse
    include Save
    include ValidMoves
    include WinAndDraw

    def initialize(player = Chess::Player)
      @white_player = player.new
      @black_player = player.new
    end

    # select different actions based on what was clicked
    # @param board [Chess::Board]
    # @param clicked [String]
    # @param board_pos [Array]
    # @param mouse_coord [Array]
    # @return [nil,Integer] nil or Exit Code 0
    def select_click_action(board, clicked, board_pos, mouse_coord)
      return if clicked == 'outside'

      if clicked == 'board'
        board_action(board, board_pos)
      else
        button_action(board, mouse_coord)
      end
    end

    # actions for clicks on board
    # @param board [Chess:Board]
    # @param board_pos [Array]
    # @return [nil,Integer] nil or Exit Code 0
    def board_action(board, board_pos)
      player = if board.current_player == 'w'
                 @white_player
               else
                 @black_player
               end
      update_castling_rights(board)
      valid_moves = player_turn(player, board, board_pos)
      update_king_status(board)
      redraw_display(board.data, valid_moves)
      detect_win_or_draws(board)
    end

    # actions for clicks on buttons
    # @param board [Chess::Board]
    # @param mouse_coord [Array]
    # @return [nil,Integer] nil or Exit Code 0
    def button_action(board, mouse_coord)
      type = button_type(mouse_coord)
      if type == 'save&exit'
        save_and_exit(board)
      else
        game_exit
      end
    end

    # player turn to select move
    # @param player [Chess::Player]
    # @param board [Chess::Board]
    # @param board_pos [Array]
    # @return [void]
    def player_turn(player, board, board_pos)
      piece = board.piece_at(*board_pos)
      if player.selected_piece == '' || same_color?(board.current_player, piece)
        select_piece(piece, player, board)
      else
        select_move(player, board, board_pos)
        []
      end
    end

    # player turn to select move
    # @param piece any subclass of {Chess::Pieces::Piece}
    # @param player [Chess::Player]
    # @param board [Chess::Board]
    # @return [void]
    def select_piece(piece, player, board)
      player.selected_piece = piece if same_color?(board.current_player, piece)
      if player.selected_piece == ''
        []
      else
        player.selected_piece.valid_moves = valid_moves(piece, board)
      end
    end

    # selects move to play
    #
    # @param player [Chess::Player]
    # @param board [Chess::Board]
    # @param move_pos [Array]
    # @return [void]
    def select_move(player, board, move_pos)
      player.select_move(board, move_pos)
      player.selected_piece.valid_moves = []
      player.selected_piece = ''
    end

    # checks if current_player and piece have same color
    #
    # @param current_player [String] from {Chess::Board#current_player}
    # @param piece any subclass of {Chess::Pieces::Piece}
    def same_color?(current_player, piece)
      piece.color.chr == current_player unless piece == ''
    end

    # updates king's @in_check attribute
    #
    # @param board [Chess::Board]
    # @return [void]
    def update_king_status(board)
      current_player = board.current_player
      board.current_player = 'b'
      board.white_king.in_check?(board, board.black_pieces)
      board.current_player = 'w'
      board.black_king.in_check?(board, board.white_pieces)
      board.current_player = current_player
    end

    # updates castling_rights for board
    #
    # @param board [Chess::Board]
    # @return [void]
    def update_castling_rights(board)
      return if board.castling_rights == ''

      location_piece_color_and_rights = {
        h0: [Chess::Pieces::Rook, 'w', 'K'],
        a0: [Chess::Pieces::Rook, 'w', 'Q'],
        e0: [Chess::Pieces::King, 'w', 'KQ'],
        h7: [Chess::Pieces::Rook, 'b', 'k'],
        a7: [Chess::Pieces::Rook, 'b', 'q'],
        e7: [Chess::Pieces::King, 'b', 'kq']
      }
      update_castling_rights_for_each_pos(board, location_piece_color_and_rights)
    end

    # helper method for {#update_castling_rights}
    #
    # @param board [Chess::Board]
    # @param  location_piece_color_and_rights [Hash]
    # @return [void]
    def update_castling_rights_for_each_pos(board, location_piece_color_and_rights) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      location_piece_color_and_rights.each_key do |pos|
        type = location_piece_color_and_rights[pos].first
        color = location_piece_color_and_rights[pos][1]
        rights = location_piece_color_and_rights[pos].last
        position = pos.to_s.chars
        file = position.first
        rank = position.last.to_i
        piece = board.piece_at(file, rank)
        rights = rights.chars
        rights.each do |right|
          board.castling_rights.sub!(right, '') unless piece.is_a?(type) && same_color?(color, piece)
        end
      end
    end
  end
end
