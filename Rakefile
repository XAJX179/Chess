# frozen_string_literal: true

desc 'runs tests by default.'
task default: %i[tests docs graph] do
  puts 'default rake run completed.'
end

desc 'says hello to user'
task :docs do
  sh 'yard doc --private'
  puts 'docs generated.'
end

desc 'running rspec'
task :tests do
  sh 'rspec -f p'
  puts 'rspec completed.'
end

desc 'docs graph'
task graph: %i[docs] do
  sh 'yard graph --full --private --dependencies | circo -T pdf -o doc/diagram.pdf'
  puts 'graph generated'
end
