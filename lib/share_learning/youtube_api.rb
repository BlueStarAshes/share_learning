require 'http'
require 'json'

module YouTube
  # using YouTube API to get playlists
  class YouTubeAPI
    max_results = 8 # number of videos that should be returned
    YouTube_URL = 'https://www.googleapis.com/youtube/v3/search?part=snippet&type=playlist&order=relevance&maxResults=' + max_results.to_s

    def self.config=(credentials)
      @config ? @config.update(credentials) : @config = credentials
    end

    def self.config
      return @config if @config
      @config = { api_key: ENV['YOUTUBE_API_KEY'] } # export YOUTUBE_API_KEY=....
    end

    # Retrieve the search results
    def self.get_playlist(keyword)
      search_response =
        HTTP.get(YouTube_URL + '&q=' + keyword.split().join('+') + '&key=' + config[:api_key])
      JSON.parse(search_response)
    end
  end
end
