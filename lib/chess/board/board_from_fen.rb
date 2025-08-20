# frozen_string_literal: true

# Chess
module Chess
  # create board from fen_code
  module BoardFromFenCode
    # generate game’s data from FEN code.
    # @param fen_code [String]
    # @return [void]
    def generate_data(fen_code)
      fen_parts_array = fen_code.split
      board_data = fen_parts_array[0]
      @current_player = fen_parts_array[1]
      @castling_rights = fen_parts_array[2]
      @possible_en_passant_target = fen_parts_array[3]
      @half_move = fen_parts_array[4].to_i
      @full_move = fen_parts_array[5].to_i

      create_board(board_data)
    end

    # creates board data
    # @param board_data [String] board_data part of FEN code
    # @return [Hash] board data
    def create_board(board_data)
      ranks = board_data.split('/')
      files = ('a'..'h') # value for 'a' to 'h'
      board = files.to_h { |file| [file, Array.new(8) { '' }] } # empty board

      board = fill_board(ranks, board)
      @data = board
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
          insert_piece(board, index, ranks_array_index, letter)
        else
          index += letter.to_i
        end
      end
    end

    # insert a piece on given board
    def insert_piece(board, index, ranks_array_index, letter)
      shift_ord = 96
      file = (shift_ord + index).chr
      rank = ranks_array_index

      board[file][rank] = create_piece(letter)
      piece_pos = [file, rank]
      board[file][rank].pos = piece_pos
    end

    # create piece from the letter
    # @param letter [String]
    # @return any subclass of {Chess::Pieces::Piece}
    def create_piece(letter)
      if letter == letter.upcase
        piece = white_piece(letter)
        @white_pieces << piece
      else
        piece = black_piece(letter)
        @black_pieces << piece
      end
      piece
    end

    # create white color piece from the letter
    # @param letter [String]
    # @return any subclass of {Chess::Pieces::Piece} with color white
    def white_piece(letter) # rubocop:disable Metrics/MethodLength
      color = 'white'
      case letter
      when 'R'
        Chess::Pieces::Rook.new(color)
      when 'N'
        Chess::Pieces::Knight.new(color)
      when 'B'
        Chess::Pieces::Bishop.new(color)
      when 'Q'
        Chess::Pieces::Queen.new(color)
      when 'K'
        @white_king = Chess::Pieces::King.new(color)
      when 'P'
        Chess::Pieces::Pawn.new(color)
      end
    end

    # create black color piece from the letter
    # @param letter [String]
    # @return any subclass of {Chess::Pieces::Piece} with color black
    def black_piece(letter) # rubocop:disable Metrics/MethodLength
      color = 'black'
      case letter
      when 'r'
        Chess::Pieces::Rook.new(color)
      when 'n'
        Chess::Pieces::Knight.new(color)
      when 'b'
        Chess::Pieces::Bishop.new(color)
      when 'q'
        Chess::Pieces::Queen.new(color)
      when 'k'
        @black_king = Chess::Pieces::King.new(color)
      when 'p'
        Chess::Pieces::Pawn.new(color)
      end
    end
  end
end
