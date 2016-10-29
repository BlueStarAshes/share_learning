require 'simplecov'
SimpleCov.start

require 'minitest/autorun' 
require 'minitest/rg' 
require 'yaml'
require 'json'
require 'vcr'
require 'webmock'

require_relative '../lib/youtube_playlist'

FIXTURES_FOLDER = 'fixtures' 
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes" 
CASSETTE_FILE = 'youtube_api'

# CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))
if File.file?('config/credentials.yml')
  CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
  ENV['YOUTUBE_API_KEY'] = CREDENTIALS[:api_key]
end