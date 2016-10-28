require_relative '../lib/youtube_api'

module YouTube
  # Playlist on Youtube
  class YouTubePlaylist
    attr_reader :playlists
    def initialize(youtube_api)
      @youtube_api = youtube_api
      @playlists = @youtube_api.get_playlist
    end

    def print_playlist_info
      youtube_res = @playlists
      youtube_res.each do |playlist|
        puts "Course: #{playlist['title']}"
        puts "Description: #{playlist['description']}"
        puts "imaage: #{playlist['image']}"
        puts "URL: #{playlist['url']}"
        puts
      end
    end
  end
end
