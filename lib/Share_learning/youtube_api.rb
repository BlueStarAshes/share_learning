require 'http'
require 'json'

module YouTube
  #using YouTube API to get playlists
  class YouTubeAPI
    maxResults = 5 #number of videos that should be returned 
    YouTube_URL = 'https://www.googleapis.com/youtube/v3/search?part=snippet&type=playlist&order=relevance&maxResults=' + maxResults.to_s 

    def initialize(api_key:, keyword:)
      @api_key = api_key
      @keyword = keyword
    end

    #Retrieve the search results and get information of playlists 
    def get_playlist
      return @info if @info
      search_response =
        HTTP.get(YouTube_URL + '&q=' + @keyword.split().join("+") + '&key=' + @api_key)
      json_response = JSON.parse(search_response)

      results = []
      json_response['items'].each do |playlist|
        title = playlist['snippet']['title']
        des = playlist['snippet']['description']
        image = playlist['snippet']['thumbnails']['high']['url']
        playlistId = playlist['id']['playlistId']
        url = 'https://www.youtube.com/channel/' + playlistId
        results.push({'title' => title, 'description' => des, 'image' => image, 'url' => url})
        # puts "Playlist: #{title}" 
        # puts "Description: #{des}"
        # puts "URL: #{url}"
        # puts
      end
      @info = results
    end
  end
end
