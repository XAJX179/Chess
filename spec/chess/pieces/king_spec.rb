# frozen_string_literal: true

describe Chess::Pieces::King do
  subject(:board) { Chess::Board.new('r3k1nr/pppp1ppp/4p3/6Q1/8/8/PPP2PPP/R3K2R w KQkq - 0 1') }

  describe '#possible_moves' do
    context 'when called on white King at e1 with white current player' do
      it 'returns correct moves' do
        piece = board.piece_at('e', 0)
        moves = piece.possible_moves(board)
        display_board(board, moves)
        expect(moves).to contain_exactly(['e', 1], ['f', 0], ['d', 0], ['d', 1])
      end
    end

    # TODO: implement tests for castling

    # TODO: implement tests for in_check?
  end
end
