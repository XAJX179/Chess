# frozen_string_literal: true

# Display is a module included inside Chess::Game

describe 'Display' do
  subject(:game) { Chess::Game.new }

  describe '#display_board' do
    let(:board) { Chess::Board.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1') }

    context 'when called with board data' do
      it 'prints display for board to stdout' do
        expect { game.display_board(board.data) }.to output.to_stdout
      end
    end
  end
end
