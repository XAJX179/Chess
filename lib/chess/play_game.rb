# frozen_string_literal: true

# This is a script file handling procedular stuff of this game.

# Starts a Chess Game
#
# see {Chess::Display#prompt_start_choices} for start choices.
#
# @return [void]
def start_game
  game_obj = Chess::Game.new

  choice = game_obj.prompt_start_choices
  case choice
  when 1 then load_game_with_code(
    'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
  ) # new game_obj FEN code
  when 2 then select_save(game_obj)
  when 3 then enter_code(game_obj)
  else start_game end
end

# choice to resume a saved game_obj.
#
# {Save#read} is used to read the file data
# @return [void]
def select_save(game_obj)
  fen_code = game_obj.prompt_select_save(game_obj.read)
  load_game_with_code(game_obj, fen_code)
end

# choice to start a game_obj using FEN code
#
# {Chess::Display#prompt_enter_code} is used for prompting user.
# @return [void]
def enter_code(game_obj)
  fen_code = game_obj.prompt_enter_code
  load_game_with_code(game_obj, fen_code)
end

# loads a game with given code
# @param fen_code [String] Fen notation for chess board.
# @return [void]
def load_game_with_code(game, fen_code)
  board = Chess::Board.new(fen_code)
  game.display_board(board.data)
end
