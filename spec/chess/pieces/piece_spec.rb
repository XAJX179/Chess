# frozen_string_literal: true

describe Chess::Pieces::Piece do
  subject(:piece) { described_class.new('white') }

  context 'when called with "white" as parameter' do
    it 'initializes @color with "white"' do
      expect(piece.color).to eq('white')
    end
  end

  context 'when called with "black" as parameter' do
    it 'initializes @color with "black"' do
      piece = described_class.new('black')
      expect(piece.color).to eq('black')
    end
  end
end
