require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'json'
require 'vcr'
require 'webmock'

require_relative '../lib/share_learning'

FIXTURES_FOLDER = 'fixtures'.freeze
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes".freeze
CASSETTE_FILE = 'youtube_api'.freeze

# read credentials from a Yaml file into environment variables
if File.file?('../config/credentials.yml')
  credentials = YAML.load(File.read('../config/credentials.yml'))
  ENV['YOUTUBE_API_KEY'] = credentials[:api_key]
end
