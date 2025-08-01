# frozen_string_literal: true

describe Chess::Pieces::Rook do
  subject(:board) { Chess::Board.new('r1kbB2R/8/8/P2R2pp/pB2r2P/8/4B3/R1Kb3r w - - 0 1') }

  describe '#possible_moves' do
    context 'when called on white Rook at a1 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('a', 1)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['a', 2], ['a', 3], ['a', 4], ['b', 1])
      end
    end

    context 'when called on white Rook at a1 with black current player' do
      it 'returns empty' do
        black_player_board = Chess::Board.new('r1kbB2R/8/8/P2R2pp/pB2r2P/8/4B3/R1Kb3r b - - 0 1')
        piece = black_player_board.piece_at('a', 1)
        moves = piece.possible_moves(black_player_board)
        display_board(black_player_board, moves)
        expect(moves).to be_empty
      end
    end

    context 'when called on white Rook at h8 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('h', 8)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['h', 7], ['h', 6], ['h', 5], ['g', 8], ['f', 8])
      end
    end
  end
end
