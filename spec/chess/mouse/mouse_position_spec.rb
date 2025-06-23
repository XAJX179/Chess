# frozen_string_literal: true

describe 'Mouse' do
  subject(:game) { Chess::Game.new }

  describe '#buttons_touched?' do
    context 'when button clicked' do
      it 'returns true' do
        expect(game.buttons_touched?([6, 11])).to be(true)
      end
    end

    context 'when not clicked' do
      it 'returns false' do
        expect(game.buttons_touched?([6, 13])).to be(false)
      end
    end
  end
end
