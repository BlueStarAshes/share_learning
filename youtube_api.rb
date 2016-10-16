require 'http'
require 'json'

class YouTubeAPI
  @@DEVELOPER_KEY = 'Your_API_Key' #API key from the APIs & auth > Credentials (Google Developers Console)
  @@maxResults =5 #number of videos that should be returned 

  #Identify YouTube API key
  def valid_APIkey
  	access_response = 
  	  HTTP.get('https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=' + \
  	  	@@maxResults.to_s + '&key=' + @@DEVELOPER_KEY)
  	response = JSON.parse(access_response)
  	begin
  	  response['error'].each do |item|
  		return item[1][0]
  	  end
  	rescue
  	  return {"reason" => 'true'}
  	end
  end

  #Retrieve the search results and get information of videos 
  def get_videos(keyword)
    search_response =
      HTTP.get('https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=' + \
      	@@maxResults.to_s + '&order=relevance&q=' + keyword + '&type=video&key=' + @@DEVELOPER_KEY)
    json_response = JSON.parse(search_response)

    results = []
    json_response['items'].each do |video|
      video_title = video['snippet']['title']
      video_des = video['snippet']['description']
      video_url = 'https://www.youtube.com/watch?v=' + video['id']['videoId']
      results.push({'title' => video_title, 'videoId' => video['id']['videoId']})
      # puts "Course: #{video_title}" 
      # puts "Description: #{video_des}"
      # puts "URL: #{video_url}"
      # puts
    end
    return results
  end
end

# Prompt user to input the keyword of course 
# puts "Input the keyword for course name or instructor's name: "
# keyword = (gets.chomp).split().join("+")
# YouTubeAPI.new.get_videos(keyword)
#YouTubeAPI.new.valid_APIkey

#https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=5&order=relevance&q=google&type=video&key=
