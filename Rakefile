require 'rake/testtask'

desc 'run tests'
task :spec do
	sh 'ruby spec/udacity_api_spec.rb spec/coursera_api_spec.rb'
end

desc 'delete cassette fixtures'
task :wipe do
  sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
    puts(ok ? 'Cassettes deleted' : 'No casseettes found')
  end
end

namespace :quality do
	desc 'run all quality checks'
	task all: [:rubocop, :flog, :flay]

	task :rubocop do
		sh 'rubocop lib/udacity_course.rb lib/coursera_*'
		puts "\n\n"
	end

	task :flog do
		sh 'flog lib/udacity_course.rb lib/coursera_*'
		puts "\n\n"
	end

	task :flay do
		sh 'flay lib/udacity_course.rb lib/coursera_*'
		puts "\n\n"
	end
end
