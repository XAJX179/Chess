# frozen_string_literal: true

describe Chess do
  describe '#start' do
    context 'when called' do
      it 'calls start_game' do
        # remove this test if doesn't work
        expect_any_instance_of(Object).to receive(:start_game) # rubocop:disable RSpec/AnyInstance
        described_class.start
      end
    end
  end
end
