# frozen_string_literal: true

require_relative '../../../lib/chess'

describe Chess::Pieces::Pawn do
  subject(:pawn) { described_class.new }

  it 'output test' do
    expect { pawn.test }.to output("hello world\n").to_stdout
  end
end
