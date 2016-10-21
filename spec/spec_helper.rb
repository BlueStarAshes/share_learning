require 'minitest/autorun'
require 'minitest/rg'
require 'json'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative '../lib/udacity_api'
require_relative '../lib/udacity_course'

FIXTURES_FOLDER = 'fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
CASSETTE_FILE = 'udacity_api'
# CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
RESULT_FILE = "#{FIXTURES_FOLDER}/udacity_api_results.json"
UDACITY_RESULT = JSON.parse(File.read(RESULT_FILE), :symbolize_names => true)