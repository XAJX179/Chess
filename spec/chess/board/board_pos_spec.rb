# frozen_string_literal: true

describe 'Chess::BoardPos' do
  subject(:board) { Chess::Board.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 2 1') }

  describe '#pos_in_range?' do
    context 'when called with pos in valid range' do
      it do
        expect(board.pos_in_range?(['a', 5])).to be(true)
      end
    end

    context 'when called with invalid range pos' do
      it do
        expect(board.pos_in_range?(['a', 8])).to be(false)
      end
    end
  end
end
