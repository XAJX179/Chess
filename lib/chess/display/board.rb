# frozen_string_literal: true

# Chess
module Chess
  # Console Display
  module Display
    # displays board with ASCII characters
    # @param board_data [Hash]
    # @return [void]
    def display_board(board_data, valid_moves = [])
      print_files(board_data)
      print_board_data(board_data, valid_moves)
      print_files(board_data)
    end

    # prints the board data
    #
    # @param board_data [Hash]
    # @return [void]
    def print_board_data(board_data, valid_moves)
      shift_rank = 1
      (0..7).reverse_each do |rank|
        print rank + shift_rank
        ('a'..'h').each do |file|
          bg_color_name = square_bg_color_name(file, rank + shift_rank)
          print_square(board_data, file, rank, bg_color_name, valid_moves)
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

    # prints a single square
    #
    # @param board_data [Hash]
    # @param file [String]
    # @param rank [Integer]
    # @param bg_color_name [Symbol]
    # @return [void]
    def print_square(board_data, file, rank, bg_color_name, valid_moves)
      piece = board_data[file][rank]
      shift_rank = 1
      square_pos = [file, rank + shift_rank]
      if piece == ''
        print square_string(piece, ' ', bg_color_name, square_pos, valid_moves)
      else
        print_piece_square(piece, bg_color_name, square_pos, valid_moves)
      end
    end

    def print_piece_square(piece, bg_color_name, square_pos, valid_moves) # rubocop:disable Metrics/MethodLength
      case piece
      when Pieces::Rook
        print square_string(piece, "\u{265C}", bg_color_name, square_pos, valid_moves)
      when Pieces::Knight
        print square_string(piece, "\u{265E}", bg_color_name, square_pos, valid_moves)
      when Pieces::Bishop
        print square_string(piece, "\u{265D}", bg_color_name, square_pos, valid_moves)
      when Pieces::Queen
        print square_string(piece, "\u{265B}", bg_color_name, square_pos, valid_moves)
      when Pieces::King
        print square_string(piece, "\u{265A}", bg_color_name, square_pos, valid_moves)
      when Pieces::Pawn
        print square_string(piece, "\u{265F}", bg_color_name, square_pos, valid_moves)
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

    # arrange and format strings for the square
    #
    # @param piece [Chess::Piece]
    # @param unicode [String]
    # @param bg_color_name [Symbol]
    # @return [String]
    def square_string(piece, unicode, bg_color_name, square_pos, valid_moves)
      if piece == ''
        bg_color("#{move_dots(square_pos, valid_moves)}\u{00A0}\u{00A0}", bg_color_name)
      elsif piece.is_a?(Chess::Pieces::King)
        piece_color = piece.color
        bg_color("#{move_dots(square_pos, valid_moves)}#{color(unicode, piece_color.to_sym)}#{
            king_check_dot(piece, square_pos)}", bg_color_name)
      else
        piece_color = piece.color
        bg_color("#{move_dots(square_pos, valid_moves)}#{color(unicode, piece_color.to_sym)} ", bg_color_name)
      end
    end

    def move_dots(square_pos, valid_moves)
      if valid_moves.include?(square_pos)
        color("\u{2022}", :black)
      else
        "\u00A0"
      end
    end

    def king_check_dot(king, king_pos)
      if king.in_check?(king_pos)
        color("\u{29BE}", :red)
      else
        "\u00A0"
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

    def redraw_display(board_data, valid_moves = [])
      system 'clear'
      display_board(board_data, valid_moves)
      display_buttons
    end
  end
end
