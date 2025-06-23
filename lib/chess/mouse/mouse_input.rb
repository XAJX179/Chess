# frozen_string_literal: true

# Chess
module Chess
  # Mouse
  module Mouse
    # starts listening mouse input in console
    def start_mouse_input
      warn_tmux_users if ENV['TMUX']
      system('stty -icanon -echo') # Disable canonical mode and echo in terminal
      enable_mouse_tracking
      begin
        input_loop
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
    def input_loop
      puts 'Waiting for mouse press... Press Ctrl+C to quit.'
      file_coords = generate_file_coords
      rank_coords = generate_rank_coords
      loop do
        char = $stdin.getc
        next unless char == "\e"

        coord = read_input(char)
        clicked_element(coord, file_coords, rank_coords)
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
  end
end
