require 'http'
require 'json'

module ShareLearning
  # Service for all Udacity API calls
  class UdacityAPI
    # get all courses info in json format through RESTful API
    def acquire_json_response
      url = 'https://www.udacity.com/public-api/v0/courses'
      response = HTTP.get(URI.parse(url))
      JSON.parse(response)
    end

    # get all courses information
    def get_all_courses(json_response)
      json_response['courses'].each do |course|
        return course['title'] + "\nhomepage: " + course['homepage']
      end
    end

    # get course information by course id
    def get_course_by_id(json_response, id)
      json_response['courses'].each do |course|
        next unless course['key'] == id
        return course['title'] + "\nhomepage: " + course['homepage']
      end
    end

    # get course information by course title
    def get_course_by_title(json_response, title)
      json_response['courses'].each do |course|
        next unless course['title'] == title

        return course['title'] + "\nhomepage: " + course['homepage']
      end
    end

    # get courses by skill levels ('', 'beginner', 'intermediate', 'advanced')
    def get_course_by_level(json_response, level)
      json_response['courses'].each do |course|
        if course['level'] == level

          return course['title'] + "\nhomepage: " + course['homepage']
        end
      end
    end

    # get courses by tracks
    def get_course_by_tracks(json_response, track_name)
      json_response['tracks'].each do |track|
        if track['name'] == track_name

          return 'courses id: ' + track['courses'].inspect
        end
      end
    end
  end
end
