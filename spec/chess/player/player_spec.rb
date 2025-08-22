# frozen_string_literal: true

describe 'Chess::Player' do
  subject(:player) { Chess::Player.new }

  describe '#change_player_turn' do
    context 'when called with current player white' do
      it 'changes to black' do
        board = Chess::Board.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 2 1')
        player.change_player_turn(board)
        expect(board.current_player).to eq('b')
      end
    end

    context 'when called with current player black' do
      it 'changes to white' do
        board = Chess::Board.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 2 1')
        player.change_player_turn(board)
        expect(board.current_player).to eq('w')
      end
    end
  end
end
