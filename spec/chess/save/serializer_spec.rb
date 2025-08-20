# frozen_string_literal: true

describe Chess::Save::Serializer do
  subject(:game) { Chess::Game.new }

  describe '#serialize' do
    context 'when called' do
      let(:data) do
        {
          default: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
        }
      end

      it 'serializes the string' do
        expect(game.serialize(data)).to eq(
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
