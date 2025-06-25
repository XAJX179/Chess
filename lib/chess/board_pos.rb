# frozen_string_literal: true

# Chess
module Chess
  # Board
  class Board
    # the north pos from the given pos
    def north_pos(file, rank)
      pp 'north_pos'
      [file, rank + 1]
    end

    # the south pos from the given pos
    def south_pos(file, rank)
      [file, rank - 1]
    end

    # the east pos from the given pos
    def east_pos(file, rank)
      [(file.ord - 1).chr, rank]
    end

    # the west pos from the given pos
    def west_pos(file, rank)
      [(file.ord + 1).chr, rank]
    end

    # the north_east_pos pos from the given pos
    def north_east_pos(file, rank)
      [(file.ord - 1).chr, rank + 1]
    end

    # the north_west_pos pos from the given pos
    def north_west_pos(file, rank)
      [(file.ord + 1).chr, rank + 1]
    end

    # the south_east_pos pos from the given pos
    def south_east_pos(file, rank)
      [(file.ord - 1).chr, rank - 1]
    end

    # the south_west_pos pos from the given pos
    def south_west_pos(file, rank)
      [(file.ord + 1).chr, rank - 1]
    end

    def pos_nil?((file, rank))
      piece_at(file, rank).nil?
    end
  end
end
