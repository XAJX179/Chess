# frozen_string_literal: true

require_relative 'display/display'

# Chess
module Chess
  # Game class
  class Game
    include Display

    def start
      choice = prompt_start_choices
      case choice
      when 1 then load_game_with_code('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1') # new game FEN code
      when 2 then select_save
      when 3 then enter_code
      else start end
    end

    private

    def select_save
      fen_code = prompt_select_save
      load_game_with_code(fen_code)
    end

    def enter_code
      fen_code = prompt_enter_code
      load_game_with_code(fen_code)
    end

    def load_game_with_code(fen_code)
    end
  end
end
