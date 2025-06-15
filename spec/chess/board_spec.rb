# frozen_string_literal: true

describe Chess::Board do
  subject(:board) { described_class.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1') }

  describe '#initialize' do
    context 'when called' do
      it 'generates board data' do
        file = 'a'
        expect(board.data[file][0]).to be_instance_of(Chess::Pieces::Rook)
      end
    end
  end
end
