# frozen_string_literal: true

describe 'Chess::Game' do
  subject(:game) { Chess::Game.new }

  describe '#detect_win_or_draws' do
    context 'when player gets checkmate' do
      it 'detects checkmate and exits game' do
        board = Chess::Board.new('8/P7/8/8/7K/5QB1/8/4R1bk b - - 48 2')
        game.update_king_status(board)
        expect(game.detect_win_or_draws(board)).to eq(0)
      end
    end

    context 'when player gets stalemate' do
      it 'detects stalemate and exits game' do
        board = Chess::Board.new('8/P7/8/8/7K/6B1/5Q2/4R1bk b - - 48 2')
        game.update_king_status(board)
        expect(game.detect_win_or_draws(board)).to eq(0)
      end
    end

    context 'when player gets fifty move draw' do
      it 'detects draw and exits game' do
        board = Chess::Board.new('8/P7/8/8/7K/6B1/8/4R1bk b - - 99 2')
        game.select_click_action(board, 'board', ['h', 0], [nil, nil])
        game.select_click_action(board, 'board', ['g', 1], [nil, nil])
        expect(game.detect_win_or_draws(board)).to eq(0)
      end
    end
  end
end
