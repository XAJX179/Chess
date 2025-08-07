# frozen_string_literal: true

describe Chess::Pieces::Bishop do
  subject(:board) { Chess::Board.new('r1kbB2R/8/8/P2R2pp/pB2r2P/8/4B3/R1Kb3r w - - 0 1') }

  describe '#possible_moves' do
    context 'when called on white Bishop at b4 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('b', 3)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['c', 4], ['d', 5], ['e', 6], ['f', 7], ['c', 2], ['d', 1], ['e', 0], ['a', 2])
      end
    end

    context 'when called on white Bishop at b4 with black current player' do
      it 'returns empty' do
        black_player_board = Chess::Board.new('r1kbB2R/8/8/P2R2pp/pB2r2P/8/4B3/R1Kb3r b - - 0 1')
        piece = black_player_board.piece_at('b', 3)
        moves = piece.possible_moves(black_player_board)
        display_board(black_player_board, moves)
        expect(moves).to be_empty
      end
    end

    context 'when called on white Bishop at e8 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 7)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['f', 6], ['g', 5], ['h', 4], ['d', 6], ['c', 5], ['b', 4], ['a', 3])
      end
    end

    context 'when called on white Bishop at e2 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 1)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['f', 2], ['g', 3], ['h', 4], ['d', 2], ['c', 3], ['b', 4], ['a', 5],
                                         ['f', 0], ['d', 0])
      end
    end
  end
end
