# frozen_string_literal: true

require_relative '../../lib/chess/game'

describe Chess::Game do
  subject(:game) { described_class.new }

  describe '#start' do
    context 'when called' do
      it 'Outputs intro message' do
        intro = "start game\n"
        expect { game.start }.to output(intro).to_stdout
      end
    end
  end
end
