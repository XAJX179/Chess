# frozen_string_literal: true

describe Chess::Board do
  subject(:board) { described_class.new('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1') }

  describe '#initialize' do
    context 'when called' do
      new_board_data = {
        'a' => ['R', 'P', '', '', '', '', 'p', 'r'],
        'b' => ['N', 'P', '', '', '', '', 'p', 'n'],
        'c' => ['B', 'P', '', '', '', '', 'p', 'b'],
        'd' => ['Q', 'P', '', '', '', '', 'p', 'q'],
        'e' => ['K', 'P', '', '', '', '', 'p', 'k'],
        'f' => ['B', 'P', '', '', '', '', 'p', 'b'],
        'g' => ['N', 'P', '', '', '', '', 'p', 'n'],
        'h' => ['R', 'P', '', '', '', '', 'p', 'r']
      }
      it 'generates board data' do
        expect(board.data).to eq(new_board_data)
      end
    end
  end

  describe '#create_board' do
    context 'when called' do
      created_board_data = {

        'a' => ['R', 'P', '', '', '', '', 'p', 'r'],
        'b' => ['N', 'P', '', '', '', '', 'p', 'n'],
        'c' => ['B', 'P', '', '', 'p', '', '', 'b'],
        'd' => ['Q', 'P', '', '', '', '', 'p', 'q'],
        'e' => ['K', 'P', '', '', '', '', 'p', 'k'],
        'f' => ['B', 'P', 'N', '', '', '', 'p', 'b'],
        'g' => ['', 'P', '', '', '', '', 'p', 'n'],
        'h' => ['R', 'P', '', '', '', '', 'p', 'r']

      }
      it 'creates board and assigns to @data' do
        board.create_board('rnbqkbnr/pp1ppppp/8/2p5/8/5N2/PPPPPPPP/RNBQKB1R')
        expect(board.data).to eq(created_board_data)
      end
    end
  end
end
