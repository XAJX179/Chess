# frozen_string_literal: true

# Chess
module Chess
  # Pieces
  module Pieces
    # King
    class King < Piece
      def in_check?(_king_pos)
        # TODO: implement condition for when in check
        true
      end
    end
  end
end
