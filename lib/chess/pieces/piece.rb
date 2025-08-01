# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # Piece
    class Piece
      attr_reader :color
      attr_accessor :pos, :valid_moves

      def initialize(color)
        @color = color
        @pos = []
        @valid_moves = []
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
