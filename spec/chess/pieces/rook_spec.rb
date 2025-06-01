# frozen_string_literal: true

describe Chess::Pieces::Rook do
  subject(:rook) { described_class.new }

  it 'output test' do
    expect { rook.test }.to output("hello world\n").to_stdout
  end
end
