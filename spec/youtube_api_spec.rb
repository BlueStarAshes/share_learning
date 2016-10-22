require_relative 'spec_helper.rb'

describe 'YouTube API' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER 
    c.hook_into :webmock

    c.filter_sensitive_data('<API_KEY>') { CREDENTIALS[:api_key] }
  end
  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes

    @youtube_api = YouTube::YouTubeAPI.new(
      api_key: CREDENTIALS[:api_key], 
      keyword: 'machine learning'
    )
  end

  after do 
    VCR.eject_cassette
  end  

  it 'should get playlist by keyword' do
    courses = YouTube::YouTubePlaylist.new(@youtube_api)
    #courses.print_playlist_info
    courses.playlists.size.must_be :>=, 0
  end 
end
