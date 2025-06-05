# frozen_string_literal: true

describe Save do
  subject(:game) { Chess::Game.new }

  describe '#read' do
    context 'when called' do
      it 'reads and unserializes the save.json' do
        contents = File.read('save.json')
        expect(game.read).to eq game.unserialize(contents)
      end
    end
  end
end
