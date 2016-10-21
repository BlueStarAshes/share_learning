require 'http'
require 'json'
require_relative 'udacity_api'

module Udacity
  # Service for all Udacity API calls
  class UdacityCourse
    attr_reader :json_response

    def initialize(udacity_api)
      @udacity_api = udacity_api
      @json_response = @udacity_api.acquire_json_response
    end

    # get all courses information
    def acquire_all_courses
      course_array = []
      @json_response['courses'].each do |course|
        h = { title: course['title'], intro: course['summary'], \
              link: course['homepage'], image: course['image'] }
        course_array.push(h)
      end
      course_array
    end

    # get course information by course id
    def acquire_course_by_id(id)
      @json_response['courses'].each do |course|
        next unless course['key'] == id
        h = { title: course['title'], intro: course['summary'], \
              link: course['homepage'], image: course['image'] }
        return h
      end
    end

    # get course information by course title
    def acquire_course_by_title(title)
      @json_response['courses'].each do |course|
        next unless course['title'] == title
        h = { title: course['title'], intro: course['summary'], \
              link: course['homepage'], image: course['image'] }
        return h
      end
    end

    # get courses by skill levels ('', 'beginner', 'intermediate', 'advanced')
    def acquire_courses_by_level(level)
      course_array = []
      @json_response['courses'].each do |course|
        next unless course['level'] == level
        h = { title: course['title'], intro: course['summary'], \
              link: course['homepage'], image: course['image'] }
        course_array.push(h)
      end
      course_array
    end

    # get courses by tracks (return a list of course id)
    def acquire_courses_by_tracks(track_name)
      @json_response['tracks'].each do |track|
        next unless track['name'] == track_name
        return track['courses'].inspect
      end
    end
  end
end
