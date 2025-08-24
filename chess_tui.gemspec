# frozen_string_literal: true

require_relative 'lib/chess/version'

Gem::Specification.new do |spec|
  spec.name = 'chess_tui'
  spec.version = Chess::VERSION
  spec.authors = ['X_AJ_X']
  spec.email = ['xajx179@gmail.com']

  spec.summary = 'Chess game with terminal display and mouse input , load games with FEN code or start new!'
  spec.description = 'Chess game with terminal UI written in ruby,
    prerequisite: a terminal which supports xterm ctrl sequences. (tested on xfce terminal)
    check out docs: https://xajx179.github.io/Chess
    & source: https://github.com/XAJX179/Chess'
  spec.homepage = 'https://xajx179.github.io/Chess'
  spec.license = 'MIT'
  spec.extra_rdoc_files = ['README.md']
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/XAJX179/Chess'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir['lib/**/*.rb']
  spec.files += Dir['bin/*']
  spec.files += ['save.json']

  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.post_install_message = 'Thanks for installing! by X_AJ_X'

  spec.add_dependency 'tty-prompt', '~> 0.23.1'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
