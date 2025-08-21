# frozen_string_literal: true

# Chess
module Chess
  # WinAndDraw
  module WinAndDraw
    def detect_win_or_draws(board)
      if checkmate?(board)
        puts 'Checkmate!'
        return game_exit
      end

      if stalemate?(board)
        puts 'Stalemate!'
        return game_exit
      end

      return unless fifty_move_draw?(board)

      puts 'draw'
      game_exit
    end

    def checkmate?(board)
      in_check = if board.current_player == 'w'
                   board.white_king.in_check
                 else
                   board.black_king.in_check
                 end
      return false unless in_check

      return false if any_legal_move?(board)

      true
    end

    def stalemate?(board)
      in_check = if board.current_player == 'w'
                   board.white_king.in_check
                 else
                   board.black_king.in_check
                 end
      return false if in_check

      return false if any_legal_move?(board)

      true
    end

    def any_legal_move?(board)
      pieces = if board.current_player == 'w'
                 board.white_pieces
               else
                 board.black_pieces
               end
      total_moves = []
      pieces.each do |piece|
        total_moves += valid_moves(piece, board)
      end
      total_moves != []
    end

    def fifty_move_draw?(board)
      board.half_move >= 100
    end

    # save the game
    def save_game(board)
      save_name = prompt_save_name
      fen = generate_fen_code(board)
      save(save_name, fen)
    end

    # exits the game
    def game_exit
      pp 'exiting...'
      0
    end

    # save and exit the game
    def save_and_exit(board)
      save_game(board)
      game_exit
    end
  end
end
