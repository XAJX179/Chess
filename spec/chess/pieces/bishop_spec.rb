# frozen_string_literal: true

describe Chess::Pieces::Bishop do
  subject(:bishop) { described_class.new('white') }

  it 'output test' do
    expect { bishop.test }.to output("hello world\n").to_stdout
  end
end
