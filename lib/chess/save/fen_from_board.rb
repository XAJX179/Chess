# frozen_string_literal: true

# Chess
module Chess
  # create fen_code from board
  module Save
    # Fen code from Board
    module FenCodeFromBoard
      def generate_fen_code(board)
        piece_placement = fen_piece_placement(board.data)
        current_player = board.current_player
        castling_rights = board.castling_rights
        en_passant = board.possible_en_passant_target
        half_move = board.half_move
        full_move = board.full_move

        "#{piece_placement} #{current_player} #{castling_rights} #{en_passant} #{half_move} #{full_move}"
      end

      def fen_piece_placement(board_data)
        string = ''
        (0..7).reverse_each do |rank|
          empty_space = 0
          ('a'..'h').each do |file|
            piece = board_data[file][rank]
            if piece == ''
              empty_space += 1
              string += empty_space.to_s if file == 'h'
            else
              string += empty_space.to_s unless empty_space.zero?
              string += letter_of(piece)
              empty_space = 0
            end
          end
          string += '/' unless rank.zero?
        end
        string
      end

      def letter_of(piece) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength
        letter = case piece
                 when Pieces::King
                   'k'
                 when Pieces::Bishop
                   'b'
                 when Pieces::Rook
                   'r'
                 when Pieces::Pawn
                   'p'
                 when Pieces::Queen
                   'q'
                 when Pieces::Knight
                   'n'
                 end
        if piece.white?
          letter.upcase
        else
          letter
        end
      end
    end
  end
end
