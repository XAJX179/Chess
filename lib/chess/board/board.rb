# frozen_string_literal: true

# Chess
module Chess
  # Board
  class Board
    include BoardFromFenCode
    include BoardPos
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
    attr_accessor :current_player, :castling_rights, :possible_en_passant_target,
                  :half_move, :full_move

    # Returns a new instance of Board.
    # @param fen_code [String]
    def initialize(fen_code)
      @white_pieces = []
      @black_pieces = []
      @data = generate_data(fen_code)
    end

    # returns piece at the given position
    # @param file [String]
    # @param rank [Integer]
    # @return any subclass of {Chess::Pieces::Piece}
    def piece_at(file, rank)
      shift_rank = 1
      return if @data[file].nil?

      @data[file][rank - shift_rank]
    end

    # checks if a square is empty
    # @param file [String]
    # @param rank [Integer]
    # @return [Boolean]
    def empty_at?(file, rank)
      piece_at(file, rank) == ''
    end

    def remove_piece_at((file, rank))
      shift_rank = 1
      @data[file][rank - shift_rank] = ''
    end

    def insert_piece_at(piece, (file, rank))
      shift_rank = 1
      @data[file][rank - shift_rank] = piece
    end

    def enemy_at?(file, rank)
      piece = piece_at(file, rank)
      @current_player != piece.color.chr
    end
  end
end
