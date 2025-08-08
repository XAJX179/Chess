# frozen_string_literal: true

describe Chess::Pieces::Knight do
  subject(:board) { Chess::Board.new('2nkN3/P4P2/7n/n1pN3N/N3nP2/8/8/1p1KNnp1 w - - 0 1') }

  describe '#possible_moves' do
    context 'when called on white Knight at a4 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('a', 3)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['b', 5], ['b', 1], ['c', 4], ['c', 2])
      end
    end

    context 'when called on white Knight at e1 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 0)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['d', 2], ['f', 2], ['c', 1], ['g', 1])
      end
    end

    context 'when called on white Knight at h5 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('h', 4)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['g', 6], ['g', 2], ['f', 5])
      end
    end

    context 'when called on white Knight at d5 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('d', 4)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['c', 6], ['e', 6], ['c', 2], ['e', 2], ['b', 5],
                                         ['b', 3], ['f', 5])
      end
    end

    context 'when called on white Knight at e8 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 7)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['d', 5], ['f', 5], ['c', 6], ['g', 6])
      end
    end
  end
end
