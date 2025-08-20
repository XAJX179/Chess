# frozen_string_literal: true

# Chess
module Chess
  # WinAndDraw
  module WinAndDraw
    def detect_win_or_draws(board)
      return unless fifty_move_draw?(board)

      pp 'draw'
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
