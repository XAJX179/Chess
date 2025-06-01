# frozen_string_literal: true

describe Chess::Pieces::Piece do
  subject(:piece) { described_class.new }

  it 'output test' do
    expect { piece.test }.to output("hello world\n").to_stdout
  end
end
