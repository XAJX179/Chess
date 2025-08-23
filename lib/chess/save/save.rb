# frozen_string_literal: true

# Chess
module Chess
  # Save file commands
  module Save
    include Serializer
    include FenCodeFromBoard

    # writes a save to the save file
    #
    # @param name [String]
    # @param data [String]
    # @return [void]
    def save(name, data)
      file_data = read
      file_data[name] = data
      new_data_serialized = serialize(file_data)
      File.write('save.json', new_data_serialized)
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
