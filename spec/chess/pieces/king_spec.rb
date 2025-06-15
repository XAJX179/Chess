# frozen_string_literal: true

describe Chess::Pieces::King do
  subject(:king) { described_class.new('white') }

  it 'output test' do
    expect { king.test }.to output("hello world\n").to_stdout
  end
end
