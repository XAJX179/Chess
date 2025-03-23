# frozen_string_literal: true

require_relative '../../../lib/chess'

describe Chess::Pieces::Bishop do
  subject(:bishop) { described_class.new }

  it 'output test' do
    expect { bishop.test }.to output("hello world\n").to_stdout
  end
end
