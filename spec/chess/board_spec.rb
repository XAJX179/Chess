# frozen_string_literal: true

describe Chess::Board do
  subject(:board) { described_class.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1') }

  describe '#initialize' do
    context 'when called' do
      it 'creates pieces' do
        expect(board.piece_at('a', 1)).to be_instance_of(Chess::Pieces::Rook)
      end

      it 'ignores spaces' do
        expect(board.piece_at('a', 3)).to be('')
      end

      it 'lowercase letters converts to black color pieces' do
        piece = board.piece_at('a', 8)
        expect(piece.color).to be('black')
      end

      it 'uppercase letters converts to white color pieces' do
        piece = board.piece_at('a', 1)
        expect(piece.color).to be('white')
      end

      it 'creates board with 8 files' do
        files = board.data.keys
        expect(files.length).to be(8)
      end

      it 'files have 8 ranks' do
        ranks = board.data['a']
        expect(ranks.length).to be(8)
      end
    end
  end
end
