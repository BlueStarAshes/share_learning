require_relative 'coursera_api'

module Coursera
  # This class is for Coursera courses
  class CourseraCourses
    def initialize(coursera_api)
      @coursera_api = coursera_api
      @total_course_num = @coursera_api.total_course_num
      @courses = @coursera_api.courses
    end
  end
end
