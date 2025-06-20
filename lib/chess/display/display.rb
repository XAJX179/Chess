# frozen_string_literal: true

# Chess
module Chess
  # Console Display
  module Display
    # Colors values for use in escape code.
    COLORS = {
      green: '119;149;86',
      dull_white: '235;236;208',
      white: '255;187;143',
      black: '1;1;1'
    }.freeze

    # background color the string
    #
    # @param string [String]
    # @param name [Symbol]
    # @return [String]
    def bg_color(string, name)
      value = COLORS[name]
      "\e[48;2;#{value}m#{string}\e[0m"
    end

    # color the string
    #
    # @param string [String]
    # @param name [Symbol]
    # @return [String]
    def color(string, name)
      value = COLORS[name]
      "\e[38;2;#{value}m#{string}\e[0m"
    end

    # Prompts user to select between New Game
    # /Load Save/Load Code(FEN) and returns the choice.
    #
    # @return [Integer] 0 for New Game. 1 for Load Save. 2 for Load Code(FEN).
    def prompt_start_choices
      prompt = TTY::Prompt.new
      prompt.select('Create new game or load save/code?') do |menu|
        menu.choice name: 'New Game', value: 1
        if File.file?('save.json') # if save.json exists
          menu.choice name: 'Load Save', value: 2
        else
          menu.choice name: 'Load Save', disabled: '(No Save Found.)'
        end
        menu.choice name: 'Load using Code (FEN)', value: 3
      end
    end

    # Promps User to select between saved data.
    #
    # @param save_data [Hash]
    # @return [String] the FEN code of selected save name.
    def prompt_select_save(save_data)
      names = save_data.keys
      prompt = TTY::Prompt.new
      selected_save_key = prompt.select('Select a save.') do |menu|
        names.each do |name|
          menu.choice name: name, value: name
        end
      end
      save_data[selected_save_key]
    end

    # Prompts User to enter a FEN code.
    # @note method expects user is entering a valid FEN code.
    #
    # @return [String] the FEN code entered.
    def prompt_enter_code
      prompt = TTY::Prompt.new
      prompt.ask('Enter a valid self attested FEN code : ') do |question|
        regex = %r{\A[prnbqkPRNBQK0-9/ w\-a-h]+\z} # only checks if valid characters
        # are used like 1-8,kqbnrKQBNR, w for white chance(b=bisop already),
        # a-h(for en passant) and the slash(/).
        question.required true
        question.validate regex, 'Invalid FEN Code.            '
      end
    end

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
    def print_piece(board_data, file, rank, bg_color_name) # rubocop:disable Metrics/MethodLength
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
  end
end
