# frozen_string_literal: true

describe Chess::Pieces::Queen do
  subject(:board) { Chess::Board.new('rnb1kbnr/pppp1ppp/5q2/QQ2p3/2P3Q1/2Q5/PP1PPPPP/RNBQKBNR w KQkq - 0 1') }

  describe '#possible_moves' do
    context 'when called on white Queen at a5 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('a', 5)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['a', 6], ['a', 7], ['a', 4], ['a', 3], ['b', 6], ['c', 7], ['b', 4])
      end
    end

    context 'when called on white Queen at a5 with black current player' do
      it 'returns empty' do
        black_player_board = Chess::Board.new('rnb1kbnr/pppp1ppp/5q2/QQ2p3/2P3Q1/2Q5/PP1PPPPP/RNBQKBNR b KQkq - 0 1')
        piece = black_player_board.piece_at('a', 5)
        moves = piece.possible_moves(black_player_board)
        display_board(black_player_board, moves)
        expect(moves).to be_empty
      end
    end

    context 'when called on white Queen at b5 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('b', 5)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['b', 6], ['b', 7], ['b', 4], ['b', 3], ['c', 5], ['d', 5], ['e', 5],
                                         ['c', 6], ['d', 7], ['a', 6], ['a', 4])
      end
    end

    context 'when called on white Queen at c3 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('c', 3)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['c', 2], ['d', 3], ['e', 3], ['f', 3], ['g', 3], ['h', 3], ['b', 3], ['a', 3],
                                         ['d', 4], ['e', 5], ['b', 4])
      end
    end

    context 'when called on white Queen at d1 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('d', 1)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['c', 2], ['b', 3], ['a', 4])
      end
    end

    context 'when called on white Queen at g4 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('g', 4)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['g', 5], ['g', 6], ['g', 7], ['g', 3], ['h', 4], ['f', 4], ['e', 4],
                                         ['d', 4], ['h', 5], ['f', 5], ['e', 6], ['d', 7], ['h', 3], ['f', 3])
      end
    end
  end
end
