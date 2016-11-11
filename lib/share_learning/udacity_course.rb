require 'http'
require 'json'
require_relative 'udacity_api'

module Udacity
  # Service for all Udacity API calls
  class UdacityCourse
    attr_reader :json_response, :total_course_num

    def initialize(udacity_api, data, total_course_num)
      @udacity_api = udacity_api
      @json_response = data
      @total_course_num = total_course_num
    end

    def create_hash(title, id, intro, link, image)
      { title: title, id: id, intro: intro, link: link, image: image }
    end

    # get all courses information
    def acquire_all_courses
      course_array = []
      @json_response['courses'].each do |course|
        h = create_hash(course['title'], course['key'], \
                        course['summary'], course['homepage'], \
                        course['image'])
        course_array.push(h)
      end
      course_array
    end

    # get course information by course id
    def acquire_course_by_id(id)
      acquire_course_info('key', id)
    end

    # get course information by course title
    def acquire_course_by_title(title)
      acquire_course_info('title', title)
    end

    # get course information
    def acquire_course_info(key, value)
      @json_response['courses'].each do |course|
        next unless course[key] == value
        h = create_hash(course['title'], course['key'], \
                        course['summary'], course['homepage'], \
                        course['image'])
        return h
      end
    end

    def substring?(title, summary, keyword)
      ((title.include? keyword) || (summary.include? keyword))
    end

    def append_course(course_array, course)
      h = create_hash(course['title'], course['key'], \
                      course['summary'], course['homepage'], \
                      course['image'])
      course_array.push(h)
      course_array
    end

    def acquire_courses_by_keywords(keyword)
      course_array = []
      @json_response['courses'].each do |course|
        next unless substring?(course['title'].downcase, \
                               course['summary'].downcase, keyword.downcase)

        course_array = append_course(course_array, course)
      end
      
      course_array
    end

    # # get courses by skill levels ('', 'beginner', 'intermediate', 'advanced')
    # def acquire_courses_by_level(level)
    #   course_array = []
    #   @json_response['courses'].each do |course|
    #     next unless course['level'] == level
    #     h = create_hash(course['title'], course['summary'], \
    #                     course['homepage'], course['image'])
    #     course_array.push(h)
    #   end
    #   course_array
    # end

    # # get courses by tracks (return a list of course id)
    # def acquire_courses_by_tracks(track_name)
    #   @json_response['tracks'].each do |track|
    #     next unless track['name'] == track_name
    #     return track['courses'].inspect
    #   end
    # end

    def self.find
      course_data = UdacityAPI.acquire_json_response
      total_course_num = UdacityAPI.total_course_num
      new(UdacityAPI, course_data, total_course_num)
    end

  end

end
