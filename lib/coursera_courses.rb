require_relative 'coursera_api'

module Coursera
  # This class is for Coursera courses
  class CourseraCourses
    attr_reader :total_course_num, :courses

    def initialize(coursera_api)
      @coursera_api = coursera_api
      @total_course_num = @coursera_api.retrieve_total_course_num
      @courses = @coursera_api.retrieve_all_courses
    end

    def print_all_courses
      puts "#{@total_course_num} courses:"
      count = 0
      @courses.size.times do
        course = @courses[count]
        puts "Course #{count}: #{course[:course_name]}"
        puts "\tType: #{course[:course_type]}"
        puts "\tID: #{course[:course_id]}"
        puts "\tSlug: #{course[:course_slug]}"
        puts
        count += 1
      end
    end
  end
end
