# frozen_string_literal: true

describe Chess::Pieces::Knight do
  subject(:board) { Chess::Board.new('2nkN3/P4P2/7n/n1pN3N/N3nP2/8/8/1p1KNnp1 w - - 0 1') }

  describe '#possible_moves' do
    before do
      display_board(board)
    end

    context 'when called on white Knight at a4 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('a', 4)
        expect(piece.possible_moves(board)).to contain_exactly(['b', 6], ['b', 2], ['c', 5], ['c', 3])
      end
    end

    context 'when called on white Knight at a4 with black current player' do
      it 'returns correct moves' do
        black_player_board = Chess::Board.new('2nkN3/P4P2/7n/n1pN3N/N3nP2/8/8/1p1KNnp1 b - - 0 1')
        piece = black_player_board.piece_at('a', 4)
        expect(piece.possible_moves(black_player_board)).to be_empty
      end
    end
  end
end
