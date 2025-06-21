# frozen_string_literal: true

# Save file commands
module Save
  # Serializer for saving to file and reading from file.
  module Serializer
    SERIALIZER = JSON

    # serializes with name as key and code as value for a hash
    #
    # @return [String]
    def serialize(name, code)
      hash = {}
      hash[name] = code
      SERIALIZER.dump hash
    end

    # unserializes the given string and returns the Hash
    # with save's name as keys and FEN code as values.
    #
    # @return [Hash]
    def unserialize(string)
      SERIALIZER.parse string
    end
  end
end
