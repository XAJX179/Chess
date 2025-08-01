# frozen_string_literal: true

describe Chess::Pieces::Bishop do
  subject(:board) { Chess::Board.new('r1kbB2R/8/8/P2R2pp/pB2r2P/8/4B3/R1Kb3r w - - 0 1') }

  describe '#possible_moves' do
    context 'when called on white Bishop at b4 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('b', 4)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['c', 5], ['d', 6], ['e', 7], ['f', 8], ['c', 3], ['d', 2], ['e', 1], ['a', 3])
      end
    end

    context 'when called on white Bishop at b4 with black current player' do
      it 'returns empty' do
        black_player_board = Chess::Board.new('r1kbB2R/8/8/P2R2pp/pB2r2P/8/4B3/R1Kb3r b - - 0 1')
        piece = black_player_board.piece_at('b', 4)
        moves = piece.possible_moves(black_player_board)
        display_board(black_player_board, moves)
        expect(moves).to be_empty
      end
    end

    context 'when called on white Bishop at e8 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 8)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['f', 7], ['g', 6], ['h', 5], ['d', 7], ['c', 6], ['b', 5], ['a', 4])
      end
    end

    context 'when called on white Bishop at e2 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 2)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['f', 3], ['g', 4], ['h', 5], ['d', 3], ['c', 4], ['b', 5], ['a', 6],
                                         ['f', 1], ['d', 1])
      end
    end
  end
end
