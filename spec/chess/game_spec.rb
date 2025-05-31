# frozen_string_literal: true

require_relative '../../lib/chess/game'

describe Chess::Game do
  subject(:game) { described_class.new }

  # currently Game only calls well tested 3rd party lib's methods and
  # private methods to self so no testing required.
  # Display is also just a module included in this class.
end
