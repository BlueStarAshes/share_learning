require 'net/http'
require 'json'
require 'yaml'

class UdacityAPI
  # get all courses info in json format through RESTful API
  def acquire_json_response
    url = 'https://www.udacity.com/public-api/v0/courses'
    response = Net::HTTP.get(URI.parse(url))
    data = JSON.parse(response)

    File.write('udacity_response.yml', data.to_yaml)
  end

  # get all courses information
  def get_all_courses(json_response)
    json_response['courses'].each do |course|
      # puts course['title']
      # puts 'homepage: ' + course['homepage']
      return course['title'] + "\nhomepage: " + course['homepage']
    end
  end

  # get course information by course id
  def get_course_by_id(json_response, id)
    json_response['courses'].each do |course|
      next unless course['key'] == id
      # puts course['title']
      # puts 'homepage: ' + course['homepage']
      return course['title'] + "\nhomepage: " + course['homepage']
    end
  end

  # get course information by course title
  def get_course_by_title(json_response, title)
    json_response['courses'].each do |course|
      next unless course['title'] == title
      # puts course['title']
      # puts 'homepage: ' + course['homepage']
      return course['title'] + "\nhomepage: " + course['homepage']
    end
  end

  # get courses by skill levels ('', 'beginner', 'intermediate', 'advanced')
  def get_course_by_level(json_response, level)
    json_response['courses'].each do |course|
      if course['level'] == level
        # puts course['title']
        # puts 'homepage: ' + course['homepage']
        return course['title'] + "\nhomepage: " + course['homepage']
      end
    end
  end

  # get courses by tracks
  def get_course_by_tracks(json_response, track_name)
    json_response['tracks'].each do |track|
      if track['name'] == track_name
        # print 'courses id: '
        # track['courses'].each { |course| print course + ' ' }
        return 'courses id: ' + track['courses'].inspect
      end
    end
  end
end

json_response = UdacityAPI.new.acquire_json_response
# UdacityAPI.new.get_all_courses(json_response)
# UdacityAPI.new.get_course_by_id(json_response, 'cs101')
# UdacityAPI.new.get_course_by_title(json_response, 'Intro to Java Programming')
# UdacityAPI.new.get_course_by_level(json_response, '')
# UdacityAPI.new.get_course_by_level(json_response, 'beginner')
# puts UdacityAPI.new.get_course_by_tracks(json_response, 'Data Science')
