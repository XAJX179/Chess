# frozen_string_literal: true

describe Chess::Board do
  subject(:board) { described_class.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1') }

  describe '#generate_data' do
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

  describe '#piece_at' do
    context 'when called on pos of board with piece' do
      it 'returns piece' do
        expect(board.piece_at('d', 1)).to be_instance_of(Chess::Pieces::Queen)
      end
    end

    context 'when called on empty pos of board' do
      it 'returns empty string' do
        expect(board.piece_at('d', 4)).to be('')
      end
    end
  end
end
