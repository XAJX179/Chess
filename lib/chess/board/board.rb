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
    attr_accessor :data, :current_player, :castling_rights, :possible_en_passant_target,
                  :half_move, :full_move, :white_pieces, :black_pieces, :white_king, :black_king

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
      return if @data[file].nil?

      @data[file][rank]
    end

    # checks if a square is empty
    # @param file [String]
    # @param rank [Integer]
    # @return [Boolean]
    def empty_at?(file, rank)
      piece_at(file, rank) == ''
    end

    def remove_piece_at((file, rank))
      @data[file][rank] = ''
      @black_pieces.reject! { |piece| piece.pos == [file, rank] }
      @white_pieces.reject! { |piece| piece.pos == [file, rank] }
    end

    def insert_piece_at(piece, (file, rank))
      @data[file][rank] = piece
      piece.pos = [file, rank]
      if @current_player == 'w'
        @white_pieces << piece unless @white_pieces.include?(piece)
      else
        @black_pieces << piece unless @white_pieces.include?(piece)
      end
    end

    def enemy_at?(file, rank)
      piece = piece_at(file, rank)
      @current_player != piece.color.chr
    end
  end
end
