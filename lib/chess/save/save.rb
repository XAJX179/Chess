# frozen_string_literal: true

# Chess
module Chess
  # Save file commands
  module Save
    include Serializer
    include FenCodeFromBoard

    # writes a save to the save file
    #
    # @return [void]
    def save
      pp 'saving'
    end

    # reads and returns saves from the save file.
    # {Serializer#unserialize} is used to unserialize the data.
    #
    # @return [Hash]
    def read
      contents = File.read('save.json')
      unserialize(contents)
    end
  end
end
