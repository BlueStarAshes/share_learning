require 'http'
require 'json'

@DEVELOPER_KEY = 'AIzaSyD2PwQuR1RVjJqwG9GpepHwEF-G_9w9SWk' #API key from the APIs & auth > Credentials (Google Developers Console)
@maxResults = 10 #number of videos that should be returned 

#Retrieve the search results and get information of videos 
def search(keyword)
  search_response =
  HTTP.get('https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=' + \
    @maxResults.to_s + '&order=relevance&q=' + keyword + '&type=video&key=' + @DEVELOPER_KEY)
  json_response = JSON.parse(search_response)
  json_response['items'].each do |video|
    video_title = video['snippet']['title']
    video_des = video['snippet']['description']
    video_url = 'https://www.youtube.com/watch?v=' + video['id']['videoId']
    
    puts "Course: #{video_title}" 
    puts "Description: #{video_des}"
    puts "URL: #{video_url}"
    puts
  end
end

# Prompt user to input the keyword of course 
puts "Input the keyword for course name or instructor's name: "
keyword = (gets.chomp).split().join("+")
search(keyword)

