require 'minitest/autorun' 
require 'minitest/rg' 
require 'json'

require_relative 'youtube_api'
RESULTS = JSON.parse(File.read('spec/videos_test_data.json'))

describe 'YouTube API' do
  it 'should identify valid the API key' do
    youtubeAPI = YouTubeAPI.new
    access = youtubeAPI.valid_APIkey
    access["reason"].must_equal ('true')
  end

  it 'should get videos by keyword' do
    youtubeAPI = YouTubeAPI.new
    videos = youtubeAPI.get_videos('machine learning'.split().join("+"))
    videos = {"items"=>videos}
    videos.must_equal (RESULTS)
  end	
end
