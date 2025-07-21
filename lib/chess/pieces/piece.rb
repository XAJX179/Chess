# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # Piece
    class Piece
      attr_reader :color

      def initialize(color)
        @color = color
      end

      def test
        puts 'hello world'
      end

      # checks if piece color is black
      def black?
        @color == 'black'
      end

      # checks if piece color is white
      def white?
        @color == 'white'
      end
    end
  end
end
