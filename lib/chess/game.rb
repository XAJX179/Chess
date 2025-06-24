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
    def select_click_action(clicked, board_pos, mouse_coord)
      # TODO: implement different actions
      return nil if clicked == 'outside'

      if clicked == 'board'
        board_action(board_pos)
      else
        button_action(mouse_coord)
      end
    end

    # actions for clicks on board
    # @param board_pos [Array]
    def board_action(board_pos); end

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

    def exit
      pp 'exit'
      # TODO: implement exit
    end

    def save_and_exit
      pp 'save_and_exit'
      # TODO: implement save and exit
    end
  end
end
