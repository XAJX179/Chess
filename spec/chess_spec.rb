# frozen_string_literal: true

require_relative '../lib/chess'

describe Chess do
  describe '#new' do
    context 'when called' do
      it 'Creates and returns new Game object.' do
        game = described_class.new
        expect(game).to be_instance_of(Chess::Game)
      end
    end
  end
end
