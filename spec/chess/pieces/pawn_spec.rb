# frozen_string_literal: true

describe Chess::Pieces::Pawn do
  subject(:board) { Chess::Board.new('3k4/ppp1pppp/1P2P1P1/4P3/4p3/1p2p1p1/PPP1PPPP/3K4 w - - 0 1') }

  describe '#possible_moves' do
    context 'when called on white Pawn at a2 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('a', 2)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['a', 3], ['a', 4], ['b', 3])
      end
    end

    context 'when called on white Pawn at a4 with black current player' do
      it 'returns empty' do
        black_player_board = Chess::Board.new('3k4/ppp1pppp/1P2P1P1/4P3/4p3/1p2p1p1/PPP1PPPP/3K4 b - - 0 1')
        piece = black_player_board.piece_at('a', 2)
        moves = piece.possible_moves(black_player_board)
        display_board(black_player_board, moves)
        expect(moves).to be_empty
      end
    end

    # white pieces

    context 'when called on white Pawn at b2 with white current player' do
      it 'returns empty' do
        piece = board.piece_at('b', 2)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to be_empty
      end
    end

    context 'when called on white Pawn at e4 with white current player' do
      it 'returns empty' do
        piece = board.piece_at('e', 4)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to be_empty
      end
    end

    context 'when called on white Pawn at c2 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('c', 2)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['c', 3], ['c', 4], ['b', 3])
      end
    end

    context 'when called on white Pawn at f2 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('f', 2)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['f', 3], ['f', 4], ['e', 3], ['g', 3])
      end
    end

    context 'when called on white Pawn at h2 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('h', 2)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['h', 3], ['h', 4], ['g', 3])
      end
    end

    context 'when called on white Pawn at b6 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('b', 6)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['a', 7], ['c', 7])
      end
    end

    context 'when called on white Pawn at e6 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 6)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['f', 7])
      end
    end

    # TODO: implement tests for pawn promotion

    # TODO: implement tests for pawn en passant
  end
end
