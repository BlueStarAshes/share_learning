require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'

require 'udacity'

FIXTURES_FOLDER = 'spec/fixtures'.freeze
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes".freeze
CASSETTE_FILE = 'udacity_exe'.freeze
RESULT_FILE = "#{FIXTURES_FOLDER}/udacity_exe_results.yml".freeze
UDACITY_RESULT = YAML.load(File.read(RESULT_FILE))
