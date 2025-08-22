# frozen_string_literal: true

describe 'Chess::Game' do
  subject(:game) { Chess::Game.new }

  describe '#valid_moves' do
    context 'when called on piece with no illegal moves' do
      it 'returns all possible moves' do
        board = Chess::Board.new('r3k2r/pppp1ppp/5n2/4p1Q1/8/8/PPP2PPP/2K1R2R w kq  0 3')
        piece = board.piece_at('e', 0)
        expect(game.valid_moves(piece,
                                board)).to eq([['e', 1], ['e', 2], ['e', 3], ['e', 4], ['f', 0], ['g', 0], ['d', 0]])
      end
    end

    context 'when called on piece with all illegal moves' do
      it 'returns empty array' do
        board = Chess::Board.new('8/P7/8/8/7K/6B1/8/4R1bk b - - 48 2')
        piece = board.piece_at('g', 0)
        expect(game.valid_moves(piece, board)).to eq([])
      end
    end

    context 'when called on piece with some legal and some illegal move' do
      it 'returns only legal moves' do
        board = Chess::Board.new('8/P7/8/8/7K/6B1/8/4R1bk b - - 48 2')
        piece = board.piece_at('h', 0)
        expect(game.valid_moves(piece, board)).to eq([['g', 1]])
      end
    end
  end
end
