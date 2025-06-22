# frozen_string_literal: true

# Chess
module Chess
  # Mouse
  module Mouse
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

    def warn_tmux_users
      warn 'Mouse input may not work as expected in tmux'
    end

    def enable_mouse_tracking
      print "\e[?9h" # Enable X10 mouse tracking
    end

    def disable_mouse_tracking
      print "\e[?9l" # Disable X10 mouse tracking
    end

    def input_loop
      puts 'Waiting for mouse press... Press Ctrl+C to quit.'
      shift = 32
      loop do
        char = $stdin.getc
        next unless char == "\e"

        sequence = char + $stdin.read(5) # Read the full ESC [ M SPACE Cx Cy
        coord = sequence.bytes[4..].map { |e| e - shift }
        puts "Mouse click at: #{coord}"
      end
    end
  end
end
