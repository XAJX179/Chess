# frozen_string_literal: true

# Chess
module Chess
  # Display
  module Display
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

    def prompt_select_save
      prompt = TTY::Prompt.new
      prompt.select('Select a save.') do |menu|
        # TODO: get saved codes from save.json and list them here.
        # menu.choice name: 'New Game', value: 1
      end
    end
  end
end
