# frozen_string_literal: true

# some of these tests messes up the rspec output because of redraw_display of board
describe 'Chess::Game' do
  subject(:game) { Chess::Game.new }

  let(:board) do
    Chess::Board.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 2 1')
  end

  describe '#select_click_action' do
    context 'when called with required params' do
      it 'returns nil if clicked outside' do
        expect(game.select_click_action(board, 'outside', [nil, nil], [36, 12])).to be_nil
      end
    end

    context 'when called with click on board when not selected piece' do
      it 'selects piece' do
        game.select_click_action(board, 'board', ['g', 0], [nil, nil])
        piece = board.piece_at('g', 0)
        expect(game.instance_variable_get(:@white_player).selected_piece).to be(piece)
      end
    end

    context 'when called with click on board selecting a move' do
      it 'plays the move' do
        piece = board.piece_at('g', 0)
        game.select_click_action(board, 'board', ['g', 0], [nil, nil])
        game.select_click_action(board, 'board', ['f', 2], [nil, nil])
        expect(piece.pos).to eq(['f', 2])
      end
    end

    context 'when called on a button e.g Exit' do
      it 'plays button_action' do
        value = game.select_click_action(board, 'button', [nil, nil], [20, 11])
        expect(value).to eq(0)
      end
    end

    context 'when called selecting piece and a move (completing a turn)' do
      it 'changes board current player after each turn' do
        game.select_click_action(board, 'board', ['g', 0], [nil, nil])
        expect do
          game.select_click_action(board, 'board', ['f', 2], [nil, nil])
        end.to change(board, :current_player).from('w').to('b')
      end
    end

    context 'when called for a king move' do
      it 'updates caslting rights' do # rubocop:disable RSpec/ExampleLength
        board = Chess::Board.new('r3k1nr/pppp1ppp/4p3/6Q1/8/8/PPP2PPP/R3K2R w KQkq - 0 1')
        game.select_click_action(board, 'board', ['e', 0], [nil, nil])
        game.select_click_action(board, 'board', ['c', 0], [nil, nil])
        expect do
          game.select_click_action(board, 'board', ['e', 7], [nil, nil]) # it is updated for next turn
        end.to change(board, :castling_rights).from('KQkq').to('kq')
      end

      it 'updates king status for in_check' do
        board = Chess::Board.new('r3k2r/pppp1ppp/5n2/4p1Q1/8/8/PPP2PPP/2K1R2R w kq  0 3')
        game.select_click_action(board, 'board', ['e', 0], [nil, nil])
        expect do
          game.select_click_action(board, 'board', ['e', 4], [nil, nil])
        end.to change { board.black_king.in_check }.from(false).to(true)
      end
    end
  end
end
