# frozen_string_literal: true

# Chess
module Chess
  # Mouse
  module Mouse
    # returns the position of board where mouse clicked on console display
    # @example x and y are decomposed from array
    #   clicked_element([3,2],file_coords,rank_coords)
    #
    # @param file_coords [Hash]
    # @param rank_coords [Hash]
    # @return [Array(file,rank)]
    def clicked_element((x, y), file_coords, rank_coords)
      [file_coords[x], rank_coords[y]]
    end

    # generate file coords for the display
    # @return [Hash] file_coords
    def generate_file_coords
      file_coords = {}
      file_ord = 97 # ord for "a"
      board_start_x = 2
      board_end_x = 25
      (board_start_x..board_end_x).each_slice(3) do |arr| # a board square's string length on display is 3.
        arr.each { |elem| file_coords[elem] = file_ord.chr }
        file_ord += 1
      end
      file_coords
    end

    # generate rank coord for the display
    # @return [Hash] rank_coords
    def generate_rank_coords
      rank_coords = {}
      rank = 7 # black is on upper side of board so ranks go from 8 to 1 (7 to 0 cuz index start = 0) from top to bottom
      board_start_y = 2
      board_end_y = 9
      (board_start_y..board_end_y).each do |elem|
        rank_coords[elem] = rank
        rank -= 1
      end
      rank_coords
    end

    # checks if a button was touched
    # @example x and y are decomposed from array
    #   buttons_touched?([x,y])
    def buttons_touched?((coord_x, coord_y))
      y = 11
      return false if coord_y != y

      start_x = 5
      end_x = 15
      save_and_exit = Array(start_x..end_x)
      start_x = 19
      end_x = 22
      exit = Array(start_x..end_x)
      (save_and_exit + exit).include?(coord_x)
    end

    # returns which button was clicked
    # @example x and y are decomposed from array
    #   button_type([x,y])
    # @return [String]
    def button_type((x, _y))
      if x.between?(5, 15)
        'save&exit'
      else
        'game_exit'
      end
    end
  end
end
