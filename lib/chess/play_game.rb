# frozen_string_literal: true

# This is a script file handling procedular stuff of this game.

# Starts a Chess Game
#
# see {Chess::Display#prompt_start_choices} for start choices.
#
# @return [void]
def start_game
  game = Chess::Game.new

  choice = game.prompt_start_choices
  case choice
  when 1 then load_game_with_code(
    game,
    'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
  ) # new game FEN code
  when 2 then select_save(game)
  when 3 then enter_code(game)
  else start_game end
end

# choice to resume a saved game.
#
# {Save#read} is used to read the file data
# @param game [Chess::Game]
# @return [void]
def select_save(game)
  fen_code = game.prompt_select_save(game.read)
  load_game_with_code(game, fen_code)
end

# choice to start a game using FEN code
#
# {Chess::Display#prompt_enter_code} is used for prompting user.
# @param game [Chess::Game]
# @return [void]
def enter_code(game)
  fen_code = game.prompt_enter_code
  load_game_with_code(game, fen_code)
end

# loads a game with given code
#
# @param game [Chess::Game]
# @param fen_code [String] Fen notation for chess board.
# @return [void]
def load_game_with_code(game, fen_code)
  board = Chess::Board.new(fen_code)
  system 'clear'
  game.display_board(board.data)
  players = create_players
  run_loop(game, board, players)
end

# create players for the game
# @return [Array(Chess::Player,Chess::Player)] white_player at 0 and black_player at 1
def create_players
  white_player = Chess::Player.new
  black_player = Chess::Player.new
  [white_player, black_player]
end

def run_loop(game, _board, _players)
  # pp game
  # puts board.data
  # pp players
  game.start_mouse_input
end
