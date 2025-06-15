# frozen_string_literal: true

describe Chess::Pieces::Pawn do
  subject(:pawn) { described_class.new('white') }

  it 'output test' do
    expect { pawn.test }.to output("hello world\n").to_stdout
  end
end
