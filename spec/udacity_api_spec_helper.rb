require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'json'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative '../lib/Share_learning/udacity_api.rb'
require_relative '../lib/Share_learning/udacity_course.rb'

<<<<<<< HEAD
FIXTURES_FOLDER = 'spec/fixtures'.freeze
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes".freeze
CASSETTE_FILE = 'udacity_api'.freeze
# CREDENTIALS = YAML.load(File.read('config/credentials.yml')
RESULT_FILE = "#{FIXTURES_FOLDER}/udacity_api_results.json".freeze
=======
FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
CASSETTE_FILE = 'udacity_api'
RESULT_FILE = "#{FIXTURES_FOLDER}/udacity_api_results.json"
>>>>>>> master
UDACITY_RESULT = JSON.parse(File.read(RESULT_FILE), :symbolize_names => true)
