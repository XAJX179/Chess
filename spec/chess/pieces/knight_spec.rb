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
      it 'returns empty' do
        black_player_board = Chess::Board.new('2nkN3/P4P2/7n/n1pN3N/N3nP2/8/8/1p1KNnp1 b - - 0 1')
        piece = black_player_board.piece_at('a', 4)
        expect(piece.possible_moves(black_player_board)).to be_empty
      end
    end

    context 'when called on white Knight at e1 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 1)
        expect(piece.possible_moves(board)).to contain_exactly(['d', 3], ['f', 3], ['c', 2], ['g', 2])
      end
    end

    context 'when called on white Knight at h5 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('h', 5)
        expect(piece.possible_moves(board)).to contain_exactly(['g', 7], ['g', 3], ['f', 6])
      end
    end

    context 'when called on white Knight at d5 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('d', 5)
        expect(piece.possible_moves(board)).to contain_exactly(['c', 7], ['e', 7], ['c', 3], ['e', 3], ['b', 6],
                                                               ['b', 4], ['f', 6])
      end
    end

    context 'when called on white Knight at e8 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 8)
        expect(piece.possible_moves(board)).to contain_exactly(['d', 6], ['f', 6], ['c', 7], ['g', 7])
      end
    end
  end
end
