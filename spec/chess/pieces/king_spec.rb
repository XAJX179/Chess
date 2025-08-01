# frozen_string_literal: true

describe Chess::Pieces::King do
  subject(:board) { Chess::Board.new('r3k1nr/pppp1ppp/4p3/6Q1/8/8/PPP2PPP/R3K2R w KQkq - 0 1') }

  describe '#possible_moves' do
    context 'when called on white King at e1 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 1)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['e', 2], ['f', 1], ['d', 1], ['d', 2])
      end
    end

    context 'when called on white King at e1 with black current player' do
      it 'returns empty' do
        black_player_board = Chess::Board.new('r3k1nr/pppp1ppp/4p3/6Q1/8/8/PPP2PPP/R3K2R b KQkq - 0 1')
        piece = black_player_board.piece_at('e', 1)
        moves = piece.possible_moves(black_player_board)
        display_board(black_player_board, moves)
        expect(moves).to be_empty
      end
    end

    # TODO: implement tests for castling

    # TODO: implement tests for in_check?
  end
end
