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

  describe '#fill_board' do
    context 'when called' do
      ranks = %w[rnbqkbnr pp1ppppp 8 2p5 8 5N2 PPPPPPPP RNBQKB1R]
      empty_board_hash = {
        'a' => ['', '', '', '', '', '', '', ''],
        'b' => ['', '', '', '', '', '', '', ''],
        'c' => ['', '', '', '', '', '', '', ''],
        'd' => ['', '', '', '', '', '', '', ''],
        'e' => ['', '', '', '', '', '', '', ''],
        'f' => ['', '', '', '', '', '', '', ''],
        'g' => ['', '', '', '', '', '', '', ''],
        'h' => ['', '', '', '', '', '', '', '']
      }
      filled_board_hash = {

        'a' => ['R', 'P', '', '', '', '', 'p', 'r'],
        'b' => ['N', 'P', '', '', '', '', 'p', 'n'],
        'c' => ['B', 'P', '', '', 'p', '', '', 'b'],
        'd' => ['Q', 'P', '', '', '', '', 'p', 'q'],
        'e' => ['K', 'P', '', '', '', '', 'p', 'k'],
        'f' => ['B', 'P', 'N', '', '', '', 'p', 'b'],
        'g' => ['', 'P', '', '', '', '', 'p', 'n'],
        'h' => ['R', 'P', '', '', '', '', 'p', 'r']

      }
      it 'fills board' do
        data = board.fill_board(ranks, empty_board_hash)
        expect(data).to eq(filled_board_hash)
      end
    end
  end

  describe '#fill_rank' do
    context 'when called' do
      rank = %w[P P P P P P P P]
      empty_board_hash = {
        'a' => ['', '', '', '', '', '', '', ''],
        'b' => ['', '', '', '', '', '', '', ''],
        'c' => ['', '', '', '', '', '', '', ''],
        'd' => ['', '', '', '', '', '', '', ''],
        'e' => ['', '', '', '', '', '', '', ''],
        'f' => ['', '', '', '', '', '', '', ''],
        'g' => ['', '', '', '', '', '', '', ''],
        'h' => ['', '', '', '', '', '', '', '']
      }
      rank_filled_hash = {
        'a' => ['', 'P', '', '', '', '', '', ''],
        'b' => ['', 'P', '', '', '', '', '', ''],
        'c' => ['', 'P', '', '', '', '', '', ''],
        'd' => ['', 'P', '', '', '', '', '', ''],
        'e' => ['', 'P', '', '', '', '', '', ''],
        'f' => ['', 'P', '', '', '', '', '', ''],
        'g' => ['', 'P', '', '', '', '', '', ''],
        'h' => ['', 'P', '', '', '', '', '', '']
      }
      ranks_array_index = 1
      it 'fills a rank' do
        board.fill_rank(empty_board_hash, rank, ranks_array_index)
        expect(empty_board_hash).to eq(rank_filled_hash)
      end
    end
  end
end
