require_relative 'youtube_api_spec_helper.rb'

describe 'YouTube API' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<API_KEY>') { ENV['YOUTUBE_API_KEY'] }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'should get playlist by keyword' do
    courses = YouTube::YouTubePlaylist.find(keyword: 'machine learning')
    courses.results.count.must_be :>=, 0
  end
end
