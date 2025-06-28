# frozen_string_literal: true

describe Chess::Pieces::Pawn do
  subject(:board) { Chess::Board.new('3k4/ppp1pppp/1P2P1P1/4P3/4p3/1p2p1p1/PPP1PPPP/3K4 w - - 0 1') }

  describe '#possible_moves' do
    # white pieces
    context 'when called on a2' do
      it 'returns correct 3 moves' do
        piece = board.piece_at('a', 2)
        expect(piece.possible_moves(board, ['a', 2])).to contain_exactly(['a', 3], ['a', 4], ['b', 3])
      end
    end

    context 'when called on b2' do
      it 'returns 0 moves' do
        piece = board.piece_at('b', 2)
        expect(piece.possible_moves(board, ['b', 2])).to be_empty
      end
    end

    context 'when called on e4' do
      it 'returns 0 moves' do
        piece = board.piece_at('e', 4)
        expect(piece.possible_moves(board, ['e', 4])).to be_empty
      end
    end

    context 'when called on c2' do
      it 'returns correct 3 moves' do
        piece = board.piece_at('c', 2)
        expect(piece.possible_moves(board, ['c', 2])).to contain_exactly(['c', 3], ['c', 4], ['b', 3])
      end
    end

    context 'when called on f2' do
      it 'returns correct 4 moves' do
        piece = board.piece_at('f', 2)
        expect(piece.possible_moves(board, ['f', 2])).to contain_exactly(['f', 3], ['f', 4], ['e', 3], ['g', 3])
      end
    end

    context 'when called on h2' do
      it 'returns correct 3 moves' do
        piece = board.piece_at('h', 2)
        expect(piece.possible_moves(board, ['h', 2])).to contain_exactly(['h', 3], ['h', 4], ['g', 3])
      end
    end

    context 'when called on b6' do
      it 'returns correct 2 moves' do
        piece = board.piece_at('b', 6)
        expect(piece.possible_moves(board, ['b', 6])).to contain_exactly(['a', 7], ['c', 7])
      end
    end

    context 'when called on e6' do
      it 'returns correct 1 move' do
        piece = board.piece_at('e', 6)
        expect(piece.possible_moves(board, ['e', 6])).to contain_exactly(['f', 7])
      end
    end

    # black pieces
    context 'when called on a7' do
      it 'returns correct 3 moves' do
        piece = board.piece_at('a', 7)
        expect(piece.possible_moves(board, ['a', 7])).to contain_exactly(['a', 6], ['a', 5], ['b', 6])
      end
    end

    context 'when called on b7' do
      it 'returns 0 moves' do
        piece = board.piece_at('b', 7)
        expect(piece.possible_moves(board, ['b', 7])).to be_empty
      end
    end

    context 'when called on e5' do
      it 'returns 0 moves' do
        piece = board.piece_at('e', 5)
        expect(piece.possible_moves(board, ['e', 5])).to be_empty
      end
    end

    context 'when called on c7' do
      it 'returns correct 3 moves' do
        piece = board.piece_at('c', 7)
        expect(piece.possible_moves(board, ['c', 7])).to contain_exactly(['c', 6], ['c', 5], ['b', 6])
      end
    end

    context 'when called on f7' do
      it 'returns correct 4 moves' do
        piece = board.piece_at('f', 7)
        expect(piece.possible_moves(board, ['f', 7])).to contain_exactly(['f', 6], ['f', 5], ['e', 6], ['g', 6])
      end
    end

    context 'when called on h7' do
      it 'returns correct 3 moves' do
        piece = board.piece_at('h', 7)
        expect(piece.possible_moves(board, ['h', 7])).to contain_exactly(['h', 6], ['h', 5], ['g', 6])
      end
    end

    context 'when called on b3' do
      it 'returns correct 3 moves' do
        piece = board.piece_at('b', 3)
        expect(piece.possible_moves(board, ['b', 3])).to contain_exactly(['a', 2], ['c', 2])
      end
    end

    context 'when called on e3' do
      it 'returns correct 1 move' do
        piece = board.piece_at('e', 3)
        expect(piece.possible_moves(board, ['e', 3])).to contain_exactly(['f', 2])
      end
    end
  end
end
