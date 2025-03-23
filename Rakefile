# frozen_string_literal: true

desc 'runs tests by default.'
task default: %i[hello tests] do
  puts 'default rake run completed.'
end

desc 'says hello to user'
task :hello do
  puts 'hello user'
end

desc 'running rspec'
task :tests do
  sh 'rspec -f p'
  puts 'rspec completed.'
end
