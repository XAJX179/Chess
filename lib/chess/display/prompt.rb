# frozen_string_literal: true

# Chess
module Chess
  # Console Display
  module Display
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
  end
end
