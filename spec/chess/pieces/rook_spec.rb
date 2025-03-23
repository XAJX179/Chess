# frozen_string_literal: true

require_relative '../../../lib/chess'

describe Chess::Pieces::Rook do
  subject(:rook) { described_class.new }

  it 'output test' do
    expect { rook.test }.to output("hello world\n").to_stdout
  end
end
