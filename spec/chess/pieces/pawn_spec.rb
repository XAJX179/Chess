# frozen_string_literal: true

describe Chess::Pieces::Pawn do
  subject(:board) { Chess::Board.new('3k4/ppp1pppp/1P2P1P1/4P3/4p3/1p2p1p1/PPP1PPPP/3K4 w - - 0 1') }

  describe '#possible_moves' do
    context 'when called on white Pawn at a2 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('a', 1)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['a', 2], ['a', 3], ['b', 2])
      end
    end

    # white pieces

    context 'when called on white Pawn at b2 with white current player' do
      it 'returns empty' do
        piece = board.piece_at('b', 1)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to be_empty
      end
    end

    context 'when called on white Pawn at e4 with white current player' do
      it 'returns empty' do
        piece = board.piece_at('e', 3)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to be_empty
      end
    end

    context 'when called on white Pawn at c2 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('c', 1)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['c', 2], ['c', 3], ['b', 2])
      end
    end

    context 'when called on white Pawn at f2 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('f', 1)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['f', 2], ['f', 3], ['e', 2], ['g', 2])
      end
    end

    context 'when called on white Pawn at h2 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('h', 1)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['h', 2], ['h', 3], ['g', 2])
      end
    end

    context 'when called on white Pawn at b6 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('b', 5)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['a', 6], ['c', 6])
      end
    end

    context 'when called on white Pawn at e6 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 5)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['f', 6])
      end
    end

    # TODO: implement tests for pawn promotion

    # TODO: implement tests for pawn en passant
  end
end
