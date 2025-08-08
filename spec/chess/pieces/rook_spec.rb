# frozen_string_literal: true

describe Chess::Pieces::Rook do
  subject(:board) { Chess::Board.new('r1kbB2R/8/8/P2R2pp/pB2r2P/8/4B3/R1Kb3r w - - 0 1') }

  describe '#possible_moves' do
    context 'when called on white Rook at a1 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('a', 0)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['a', 1], ['a', 2], ['a', 3], ['b', 0])
      end
    end

    context 'when called on white Rook at h8 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('h', 7)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['h', 6], ['h', 5], ['h', 4], ['g', 7], ['f', 7])
      end
    end
  end
end
