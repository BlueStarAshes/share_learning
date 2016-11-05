require 'http'
require 'json'

module Udacity
  # Service for all Udacity API calls
  class UdacityAPI
    UDACITY_URL = 'https://www.udacity.com/public-api/v0/courses'.freeze

    # get all courses info in json format through RESTful API
    def self.acquire_json_response
      response = HTTP.get(URI.parse(UDACITY_URL))
      JSON.parse(response)
    end

    # get total courses number
    def self.total_course_num
      @total_course_num = retrieve_total_course_num
    end

    def self.retrieve_total_course_num
      return @total_course_num if @total_course_num

      # Retrieve the total number of courses on the catlog
      json_resp = acquire_json_response
      @total_course_num = json_resp['courses'].size
    end
  end
end
