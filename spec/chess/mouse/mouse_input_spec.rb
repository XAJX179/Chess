# frozen_string_literal: true

describe 'Mouse' do
  subject(:game) { Chess::Game.new }

  describe '#read_input' do
    context 'when called' do
      it 'gets the x y coords from sequence' do
        char = "\e"
        sequence = "\e[M #\""
        allow($stdin).to receive(:read).and_return(sequence[1..])
        expect(game.read_input(char)).to eq([3, 2])
      end
    end
  end

  describe '#read_clicked' do
    context 'when called' do
      it 'reads board click' do
        coord = [3, 2]
        expect(game.read_clicked(['a', 8], coord)).to eq('board')
      end

      it 'reads outside click' do
        coord = [3, 22]
        expect(game.read_clicked(['a', nil], coord)).to eq('outside')
      end

      it 'reads button click' do
        coord = [15, 11]
        expect(game.read_clicked(['5', nil], coord)).to eq('button')
      end
    end
  end
end
