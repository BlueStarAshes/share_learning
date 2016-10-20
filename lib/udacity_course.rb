require 'http'
require 'json'
require_relative 'udacity_api'

module Udacity
  # Service for all Udacity API calls
  class UdacityCourse
    attr_reader :json_response

    def initialize(udacity_api)
      @udacity_api = udacity_api
      @json_response = @udacity_api.new.acquire_json_response
    end
    
    # get all courses information
    def get_all_courses
      output = ''
      @json_response['courses'].each do |course|
        output += course['title'] + "\nhomepage: " + course['homepage']
      end
      output
    end

    # get course information by course id
    def get_course_by_id(id)
      @json_response['courses'].each do |course|
        next unless course['key'] == id
        return course['title'] + "\nhomepage: " + course['homepage']
      end
    end

    # get course information by course title
    def get_course_by_title(title)
      @json_response['courses'].each do |course|
        next unless course['title'] == title
        return course['title'] + "\nhomepage: " + course['homepage']
      end
    end

    # get courses by skill levels ('', 'beginner', 'intermediate', 'advanced')
    def get_course_by_level(level)
      output = ''
      @json_response['courses'].each do |course|
        if course['level'] == level
          output += course['title'] + "\nhomepage: " + course['homepage']
        end
      end
      output
    end

    # get courses by tracks
    def get_course_by_tracks(track_name)
      output = ''
      @json_response['tracks'].each do |track|
        if track['name'] == track_name
          output += 'courses id: ' + track['courses'].inspect
        end
      end
      output
    end
  end
end
