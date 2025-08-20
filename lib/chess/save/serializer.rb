# frozen_string_literal: true

# Chess
module Chess
  # Save file commands
  module Save
    # Serializer for saving to file and reading from file.
    module Serializer
      # Serializing format used for save and load
      SERIALIZER = JSON

      # serializes the save data with save_name as keys and FEN as values
      #
      # @return [String]
      def serialize(data)
        SERIALIZER.dump data
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
end
