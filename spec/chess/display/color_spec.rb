# frozen_string_literal: true

# Display is a module included inside Chess::Game

describe 'Display' do
  subject(:game) { Chess::Game.new }

  describe '#bg_color' do
    context 'when called with string and color name' do
      it 'adds background color to the string' do
        color_name = :green
        result = game.bg_color('hello world', color_name)
        value = Chess::Display::COLORS[color_name]
        expect(result).to eq("\e[48;2;#{value}mhello world\e[0m")
      end
    end
  end

  describe '#color' do
    context 'when called with string and color name' do
      it 'adds color to the string' do
        color_name = :green
        result = game.color('hello world', color_name)
        value = Chess::Display::COLORS[color_name]
        expect(result).to eq("\e[38;2;#{value}mhello world")
      end
    end
  end
end
