# frozen_string_literal: true

# Save file commands
module Save
  # Serializer for saving to file and reading from file.
  module Serializer
    @@serializer = JSON

    # serializes with name as key and code as value for a hash
    #
    # @return [String]
    def serialize(name, code)
      hash = {}
      hash[name] = code
      @@serializer.dump hash
    end

    # unserializes the given string and returns the Hash
    # with save's name as keys and FEN code as values.
    #
    # @return [Hash]
    def unserialize(string)
      @@serializer.parse string
    end
  end
end
