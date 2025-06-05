# frozen_string_literal: true

describe Save::Serializer do
  subject(:game) { Chess::Game.new }

  describe '#serialize' do
    context 'when called' do
      let(:string) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }

      it 'serializes the string' do
        expect(game.serialize('default', string)).to eq(
          '{"default":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"}'
        )
      end
    end
  end

  describe '#unserialize' do
    let(:hash) { { 'default' => 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' } }

    context 'when called' do
      it 'unserializes the string' do
        expect(
          game.unserialize('{"default":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"}')
        ).to eq(hash)
      end
    end
  end
end
