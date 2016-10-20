require 'http'
require 'json'

module Udacity
  # Service for all Udacity API calls
  class UdacityAPI
    UDACITY_URL = 'https://www.udacity.com/public-api/v0/courses'
    # get all courses info in json format through RESTful API
    def acquire_json_response
      response = HTTP.get(URI.parse(UDACITY_URL))
      JSON.parse(response)
    end
  end
end
