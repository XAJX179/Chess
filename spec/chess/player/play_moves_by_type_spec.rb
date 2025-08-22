# frozen_string_literal: true

describe 'Chess::PlayMovesByType' do
  subject(:player) { Chess::Player.new }

  let(:board) { Chess::Board.new('3k4/ppp1pppp/1P2P1P1/4P3/4p3/1p2p1p1/PPP1PPPP/3K4 w - - 0 1') }

  describe '#play_move_by_type' do
    context 'when pawn move' do
      it 'can play pawn normal move' do
        piece = board.piece_at('h', 1)
        expect do
          player.play_move_by_type(piece, board, ['h', 2], inside_valid_moves_flag: false)
        end.to change(piece, :pos).from(['h', 1]).to(['h', 2])
      end

      it 'can play pawn attack move' do
        piece = board.piece_at('h', 1)
        expect do
          player.play_move_by_type(piece, board, ['g', 2], inside_valid_moves_flag: false)
        end.to change(piece, :pos).from(['h', 1]).to(['g', 2])
      end

      it 'can play pawn two step move' do
        piece = board.piece_at('h', 1)
        expect do
          player.play_move_by_type(piece, board, ['h', 3], inside_valid_moves_flag: false)
        end.to change(piece, :pos).from(['h', 1]).to(['h', 3])
      end

      it 'set possible en passant target when playing pawn two step move' do
        piece = board.piece_at('h', 1)
        player.play_move_by_type(piece, board, ['h', 3], inside_valid_moves_flag: false)
        expect(board.possible_en_passant_target).to eq('h2')
      end

      it 'can attack en passant target' do # rubocop:disable RSpec/ExampleLength
        piece = board.piece_at('f', 1)
        player.play_move_by_type(piece, board, ['f', 3], inside_valid_moves_flag: false)
        piece = board.piece_at('e', 3)
        expect do
          player.play_move_by_type(piece, board, ['f', 2], inside_valid_moves_flag: false)
        end.to change(piece, :pos).from(['e', 3]).to(['f', 2]).and change { board.piece_at('f', 3) }.to('')
      end

      it 'can promote pawn' do # rubocop:disable RSpec/ExampleLength
        board = Chess::Board.new('3k4/P1p1pppp/1p2P1P1/4P3/4p3/1p2p1p1/PPP1PPPP/3K4 w -  0 2')
        piece = board.piece_at('a', 6)
        allow($stdin).to receive(:getc).and_return("\n") # chooses first option which is queen
        player.play_move_by_type(piece, board, ['a', 7], inside_valid_moves_flag: false)
        piece = board.piece_at('a', 7)
        expect(piece).to be_a(Chess::Pieces::Queen)
      end

      it 'resets half move' do
        piece = board.piece_at('h', 1)
        player.play_move_by_type(piece, board, ['h', 2], inside_valid_moves_flag: false)
        expect(board.half_move).to eq(0)
      end
    end

    context 'when king move' do
      before do
        Chess::Board.new('r3k1nr/pppp1ppp/4p3/6Q1/8/8/PPP2PPP/R3K2R w KQkq - 0 1')
      end

      # TODO: write King tests
      it 'can play normal move' do
        skip 'will write later'
        piece = board.piece_at('e', 0)
        player.play_move_by_type(piece, board, ['h', 2], inside_valid_moves_flag: false)
      end
    end
  end
end
