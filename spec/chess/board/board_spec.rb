# frozen_string_literal: true

describe 'Chess::Board' do
  subject(:board) { Chess::Board.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 2 1') }

  describe '#piece_at' do
    context 'when called on pos of board with piece' do
      it 'returns piece' do
        expect(board.piece_at('d', 0)).to be_instance_of(Chess::Pieces::Queen)
      end
    end

    context 'when called on empty pos of board' do
      it 'returns empty string' do
        expect(board.piece_at('d', 3)).to be('')
      end
    end
  end

  describe '#empty_at?' do
    context 'when called on empty pos' do
      it 'returns true' do
        expect(board.empty_at?('f', 4)).to be(true)
      end
    end

    context 'when called on pos not empty' do
      it 'returns false' do
        expect(board.empty_at?('a', 6)).to be(false)
      end
    end
  end

  describe '#remove_piece_at' do
    context 'when called on a piece' do
      it 'removes the piece' do
        board.remove_piece_at(['a', 6])
        expect(board.piece_at('a', 6)).to be('')
      end

      it 'removes it from board @white_pieces or @black pieces' do
        piece = board.piece_at('a', 6)
        board.remove_piece_at(['a', 6])
        expect(board.black_pieces).not_to include(piece)
      end
    end
  end

  describe '#insert_piece_at' do
    context 'when called with piece and pos' do
      it 'inserts the piece at pos on board' do
        piece = Chess::Pieces::Rook.new('black')
        board.insert_piece_at(piece, ['a', 6])
        expect(board.piece_at('a', 6)).to be(piece)
      end

      it 'updates piece.pos' do
        piece = Chess::Pieces::Rook.new('black')
        board.insert_piece_at(piece, ['a', 6])
        expect(piece.pos).to eq(['a', 6])
      end

      it 'adds to board @white_pieces or @black_pieces' do
        # changed to white cause it is decided by current player which is 'w' rn
        piece = Chess::Pieces::Rook.new('white')
        board.insert_piece_at(piece, ['a', 6])
        expect(board.white_pieces).to include(piece)
      end
    end
  end

  describe '#enemy_at?' do
    context 'when called with pos' do
      it 'returns true if enemy color piece at pos' do
        expect(board.enemy_at?('a', 6)).to be(true)
      end

      it 'returns false if same color piece at pos' do
        expect(board.enemy_at?('a', 1)).to be(false)
      end
    end
  end

  describe '#reset_half_move' do
    context 'when called' do
      it 'resets half move to 0' do
        expect { board.reset_half_move }.to change(board, :half_move).from(2).to(0)
      end
    end
  end
end
