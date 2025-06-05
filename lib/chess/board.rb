# frozen_string_literal: true

# Chess
module Chess
  # Board
  class Board
    # 'a’ to ‘h’ are files, rnbqkp are black pieces
    # and RNBQKP are white pieces along the 8 ranks.
    # @example generated data looks like this
    #   {
    #   "a"=>["R", "P", "", "", "", "", "p", "r"],
    #   "b"=>["N", "P", "", "", "", "", "p", "n"],
    #   "c"=>["B", "P", "", "", "", "", "p", "b"],
    #   "d"=>["Q", "P", "", "", "", "", "p", "q"],
    #   "e"=>["K", "P", "", "", "", "", "p", "k"],
    #   "f"=>["B", "P", "", "", "", "", "p", "b"],
    #   "g"=>["N", "P", "", "", "", "", "p", "n"],
    #   "h"=>["R", "P", "", "", "", "", "p", "r"]
    #   }
    # @return [Hash]
    attr_reader :data

    # Returns a new instance of Board.
    # @param fen_code [String]
    def initialize(fen_code)
      @data = generate_data(fen_code)
    end

    # generate game’s data from FEN code.
    # @param fen_code [String]
    # @return [void]
    def generate_data(fen_code)
      pp fen_parts_array = fen_code.split
      pp board_data = fen_parts_array[0]
      pp fen_parts_array[1]
      pp fen_parts_array[2]
      pp fen_parts_array[3]
      pp fen_parts_array[4]
      pp fen_parts_array[5]
      create_board(board_data)
    end

    # creates board data
    # @param board_data [String] board_data part of FEN code
    # @return [Hash] board data
    def create_board(board_data)
      ranks = board_data.split('/')
      files_ord = (97..104) # value for 'a' to 'h'
      board = files_ord.to_h { |file| [file.chr, Array.new(8) { '' }] } # empty board

      board = fill_board(ranks, board)
      pp @data = board
    end

    # fills board with rank wise data.
    # @param ranks [Array]
    # @param board [Hash]
    # @return [Hash] filled board.
    def fill_board(ranks, board)
      ranks.reverse!
      ranks.each_index do |ranks_array_index|
        rank = ranks[ranks_array_index].chars
        fill_rank(board, rank, ranks_array_index)
      end
      board
    end

    # fills a rank
    # @param board [Hash]
    # @param rank [Array]
    # @param ranks_array_index [Integer]
    # @return [void]
    def fill_rank(board, rank, ranks_array_index)
      index = 0
      rank.each do |letter|
        if letter.to_i.zero?
          index += 1
          board[(96 + index).chr][ranks_array_index] = letter
        else
          index += letter.to_i
        end
      end
    end
  end
end
