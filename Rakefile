require 'rake/testtask'

namespace :tests do
  desc 'run all tests'
  task all: [:spec_udacity, :spec_coursera, :spec_youtube]

  task :spec_udacity do
    sh 'ruby spec/udacity_api_spec.rb'
    puts "\n\n"
  end

  task :spec_coursera do
    sh 'ruby spec/coursera_api_spec.rb'
    puts "\n\n"
  end

  task :spec_youtube do
    sh 'ruby spec/youtube_api_spec.rb'
    puts "\n\n"
  end
end

desc 'delete cassette fixtures'
task :wipe do
  sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
    puts(ok ? 'Cassettes deleted' : 'No casseettes found')
  end
end

namespace :quality do
	desc 'run all quality checks'
	task all: [:flog, :flay, :rubocop]

	task :rubocop do
		sh 'rubocop lib/share_learning/udacity_course.rb lib/share_learning/coursera_* lib/share_learning/youtube_playlist.rb'
		puts "\n\n"
	end

	task :flog do
		sh 'flog lib/share_learning/udacity_course.rb lib/share_learning/coursera_* lib/share_learning/youtube_playlist.rb'
		puts "\n\n"
	end

	task :flay do
		sh 'flay lib/share_learning/udacity_course.rb lib/share_learning/coursera_* lib/share_learning/youtube_playlist.rb'
		puts "\n\n"
	end
end
