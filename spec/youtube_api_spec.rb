require 'minitest/autorun' 
require 'minitest/rg' 
require 'yaml'
require 'json'

require_relative '../lib/youtube_playlist'
CREDENTIALS = YAML.load(File.read('../config/credentials.yml'))
RESULTS = JSON.parse(File.read('fixtures/youtube_response.json'))

describe 'YouTube API' do
  before do
    @youtube_api = YouTube::YouTubeAPI.new(
      api_key: CREDENTIALS[:api_key], 
      keyword: 'machine learning'
    )
  end
  it 'should get playlist by keyword' do
    courses = YouTube::YouTubePlaylist.new(@youtube_api)
    #courses.print_playlist_info
    courses.playlists.size.must_be :>=, 0
  end	
end
