# frozen_string_literal: true

# Chess
module Chess
  # Board
  module BoardPos
    # the north pos from the given pos
    def north_pos(file, rank)
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

    # checks if a pos is nil value
    # @example file and rank are decomposed from array
    #   pos_nil?(['d',0])
    def pos_nil?((file, rank))
      piece_at(file, rank).nil?
    end

    # checks if a pos is in range
    # @example file and rank are decomposed from array
    #   pos_in_range?(['d',0])
    def pos_in_range?((file, rank))
      first_rank = 0
      last_rank = 7
      first_file_ord = 'a'.ord
      last_file_ord = 'h'.ord
      rank.between?(first_rank, last_rank) && file.ord.between?(first_file_ord, last_file_ord)
    end
  end
end
