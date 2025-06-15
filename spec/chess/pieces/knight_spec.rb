# frozen_string_literal: true

describe Chess::Pieces::Knight do
  subject(:knight) { described_class.new('white') }

  it 'output test' do
    expect { knight.test }.to output("hello world\n").to_stdout
  end
end
