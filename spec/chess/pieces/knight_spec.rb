# frozen_string_literal: true

require_relative '../../../lib/chess'

describe Chess::Pieces::Knight do
  subject(:knight) { described_class.new }

  it 'output test' do
    expect { knight.test }.to output("hello world\n").to_stdout
  end
end
