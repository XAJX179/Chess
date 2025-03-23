# frozen_string_literal: true

require_relative '../../../lib/chess'

describe Chess::Pieces::King do
  subject(:king) { described_class.new }

  it 'output test' do
    expect { king.test }.to output("hello world\n").to_stdout
  end
end
