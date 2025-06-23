# frozen_string_literal: true

# Chess
module Chess
  # Console Display
  module Display
    # displays board with ASCII characters
    # @param board_data [Hash]
    # @return [void]
    def display_board(board_data)
      # TODO: implement marks for valid moves.
      print_files(board_data)
      print_board_data(board_data)
      print_files(board_data)
    end

    # prints the board data
    #
    # @param board_data [Hash]
    # @return [void]
    def print_board_data(board_data)
      shift_rank = 1
      (0..7).reverse_each do |rank|
        print rank + shift_rank
        ('a'..'h').each do |file|
          bg_color_name = square_bg_color_name(file, rank + shift_rank)
          print_piece(board_data, file, rank, bg_color_name)
        end
        print rank + shift_rank
        puts
      end
    end

    # prints files above the board 'a' to 'h'
    #
    # @param board_data [Hash]
    # @return [void]
    def print_files(board_data)
      print ' '
      board_data.each_key { |key| print " #{key} " }
      puts
    end

    # prints a single piece
    #
    # @param board_data [Hash]
    # @param file [String]
    # @param rank [Integer]
    # @param bg_color_name [Symbol]
    # @return [void]
    def print_piece(board_data, file, rank, bg_color_name) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      piece = board_data[file][rank]
      case piece
      when Pieces::Rook
        print piece_string(piece, "\u{1fa02}", bg_color_name)
      when Pieces::Knight
        print piece_string(piece, "\u{1fa04}", bg_color_name)
      when Pieces::Bishop
        print piece_string(piece, "\u{1fa03}", bg_color_name)
      when Pieces::Queen
        print piece_string(piece, "\u{1fa01}", bg_color_name)
      when Pieces::King
        print piece_string(piece, "\u{1fa00}", bg_color_name)
      when Pieces::Pawn
        print piece_string(piece, "\u{1fa05}", bg_color_name)
      else
        print bg_color('   ', bg_color_name)
      end
    end

    # returns background color name for the square at
    # given file and rank.
    #
    # @param file [String]
    # @param rank [Integer]
    # @return [Symbol]
    def square_bg_color_name(file, rank)
      if (file.ord.odd? && rank.odd?) || (file.ord.even? && rank.even?)
        :green
      else
        :dull_white
      end
    end

    # arrange and format strings for the piece
    #
    # @param piece [Chess::Piece]
    # @param unicode [String]
    # @param bg_color_name [Symbol]
    # @return [String]
    def piece_string(piece, unicode, bg_color_name)
      if piece.color == 'white'
        bg_color(" #{color(unicode, :white)}", bg_color_name) + bg_color(' ', bg_color_name)
      else
        bg_color(" #{color(unicode, :black)}", bg_color_name) + bg_color(' ', bg_color_name)
      end
    end

    # display Save & Exit and Exit buttons
    # return [void]
    def display_buttons
      print '    '
      print bg_color(color('Save & Exit', :green), :black)
      print '   '
      print bg_color(color('Exit', :green), :black)
      puts
    end
  end
end
