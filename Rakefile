require 'rake/testtask'

# task default: :spec

desc 'run tests for Coursera API'
task :spec_coursera_api do
  sh 'ruby spec/coursera_api_spec.rb'
end

desc 'delete cassette fixtures related to Coursera API'
task :wipe do
  sh 'rm spec/fixtures/cassettes/coursera_api.yml' do |ok, _|
    puts(ok ? 'Cassettes deleted' : 'No cassettes found')
  end
end

namespace :quality do
  desc 'run all quality checks on Coursera API related code'
  task all: [:flog, :flay]

  task :flog do
    sh 'flog lib/coursera_api*'
    puts "\n\n"
  end

  task :flay do
    sh 'flay lib/coursera_api*'
    puts "\n\n"
  end
end
