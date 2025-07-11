# frozen_string_literal: true

# Chess
module Chess
  # Console Display
  module Display
    # Colors values for use in escape code.
    COLORS = {
      green: '119;149;86',
      dull_white: '235;236;208',
      white: '255;187;143',
      black: '1;1;1',
      red: '249;23;32'
    }.freeze

    # background color the string
    #
    # @param string [String]
    # @param name [Symbol]
    # @return [String]
    def bg_color(string, name)
      value = COLORS[name]
      "\e[48;2;#{value}m#{string}\e[0m"
    end

    # color the string
    #
    # @param string [String]
    # @param name [Symbol]
    # @return [String]
    #
    # @note will not reset the color like #bg_color
    def color(string, name)
      value = COLORS[name]
      "\e[38;2;#{value}m#{string}"
    end
  end
end
