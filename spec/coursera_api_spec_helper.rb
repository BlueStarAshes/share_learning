require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/coursera_courses.rb'

FIXTURE_FOLDER = 'spec/fixtures'.freeze
CASSETTES_FOLDER = "#{FIXTURE_FOLDER}/cassettes".freeze
CASSETTE_FILE = 'coursera_api'.freeze
