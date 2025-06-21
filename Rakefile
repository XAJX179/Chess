# frozen_string_literal: true

desc 'runs all.'
task default: %i[tests rubocop docs graph] do
  puts 'default rake run completed.'
end

desc 'running rspec'
task :tests do
  sh 'rspec -f p'
  puts 'rspec completed.'
end

desc 'running rubocop'
task :rubocop do
  sh 'rubocop'
  puts 'rubocop completed.'
end

desc 'running yardoc'
task :docs do
  sh 'yard doc --private'
  puts 'docs generated.'
end

desc 'docs graph'
task graph: %i[docs] do
  sh 'yard graph --full --private --dependencies | circo -T pdf -o doc/diagram.pdf'
  puts 'graph generated'
end
