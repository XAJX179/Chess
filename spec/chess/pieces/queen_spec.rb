# frozen_string_literal: true

describe Chess::Pieces::Queen do
  subject(:queen) { described_class.new }

  it 'output test' do
    expect { queen.test }.to output("hello world\n").to_stdout
  end
end
