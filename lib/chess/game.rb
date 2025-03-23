# frozen_string_literal: true

# Chess
module Chess
  # Game class
  class Game
    def start
      white_player = Player.new
      black_player = Player.new
      board = Board.new
      # intro_messages(player1, player2)
      # game_loop(player1, player2, board)
      puts 'start game'
    end
  end
end
