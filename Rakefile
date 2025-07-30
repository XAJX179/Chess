# frozen_string_literal: true

desc 'runs all.'
task default: %i[tests rubocop docs graph] do
  puts 'default rake run completed.'
end

desc 'running rspec'
task :tests do
  sh 'rspec -f d'
  puts 'rspec completed.'
end

desc 'running rubocop'
task :rubocop do
  sh 'rubocop'
  puts 'rubocop completed.'
end

desc 'running yardoc'
task :docs do
  sh 'yard doc --private --asset docs/images:images - docs/Diagram.md'
  puts 'docs generated.'
end

desc 'docs graph'
task graph: %i[docs] do
  sh 'yard graph --full --private --dependencies | dot -T png -o docs/images/diagram.png'
  puts 'graph generated'
end
