# frozen_string_literal: true

# Chess
module Chess
  # Mouse
  module Mouse
    # starts listening mouse input in console
    # @param board [Chess::Board]
    def start_mouse_input(board)
      warn_tmux_users if ENV['TMUX']
      system('stty -icanon -echo') # Disable canonical mode and echo in terminal
      enable_mouse_tracking
      begin
        puts 'Waiting for mouse click... Press Ctrl+C to quit.'
        input_loop(board)
      ensure # run these even if Ctrl+C was pressed
        disable_mouse_tracking
        system('stty icanon echo') # Restore terminal to sane mode
      end
    end

    # warns tmux users that mouse may not work
    def warn_tmux_users
      warn 'Mouse input may not work as expected in tmux'
    end

    # enable the mouse tracking using xterm control sequences -
    # https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Mouse-Tracking
    def enable_mouse_tracking
      print "\e[?9h" # Enable X10 mouse tracking
    end

    # disable the mouse tracking using xterm control sequences -
    # https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Mouse-Tracking
    def disable_mouse_tracking
      print "\e[?9l" # Disable X10 mouse tracking
    end

    # runs loop for mouse input
    # @param board [Chess::Board]
    def input_loop(board) # rubocop:disable Metrics/MethodLength
      file_coords = generate_file_coords
      rank_coords = generate_rank_coords
      loop do
        char = $stdin.getc
        next unless char == "\e"

        coord = read_input(char)
        board_pos = clicked_element(coord, file_coords, rank_coords)
        clicked = read_clicked(board_pos, coord)
        return_value = select_click_action(board, clicked, board_pos, coord)
        break if game_exit?(return_value)
      end
    end

    # reads whole input sequence and returns the coords X and Y
    # @param char [Char]
    # @return [Array(x,y)]
    def read_input(char)
      shift = 32
      sequence = char + $stdin.read(5) # Read the full ESC [ M SPACE Cx Cy stored in buffer
      sequence.bytes[4..].map { |e| e - shift } # shift and return the Cx Cy only
    end

    # read what was clicked
    # @example file and rank are decomposed from array
    #   read_clicked([file,rank],coord)
    #
    # @param coord [Array]
    # @return [String]
    def read_clicked((file, rank), coord)
      if !(file.nil? || rank.nil?)
        'board'
      elsif buttons_touched?(coord)
        'button'
      else
        'outside'
      end
    end

    def game_exit?(value)
      value == 0 # rubocop:disable Style/NumericPredicate
    end
  end
end
