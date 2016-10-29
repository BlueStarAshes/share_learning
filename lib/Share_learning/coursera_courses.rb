require_relative 'coursera_api'

module Coursera
  # This class is for Coursera courses
  class CourseraCourses
    attr_reader :total_course_num, :courses

    def initialize(total_course_num, courses)
      @total_course_num = total_course_num
      @courses = courses
    end

    def self.find
      total_course_num = CourseraApi.total_course_num
      courses = CourseraApi.retrieve_all_courses
      new(total_course_num, courses)
    end

    def print_all_courses
      puts "#{@total_course_num} courses:"
      @courses.size.times do |i|
        print_course(@courses[i], i)
      end
    end

    private_class_method

    def print_course(course, sequence_number)
      puts "Course #{sequence_number}:"\
           "\tTitle: #{course[:course_name]}"\
           "\tType: #{course[:course_type]}"\
           "\tID: #{course[:course_id]}"\
           "\tSlug: #{course[:course_slug]}"\
           "\tLink: #{course[:link]}"\
           "\tDescription: #{course[:description]}"\
           "\tPhoto URL: #{course[:photo_url]}"\
           "\n"
    end
  end
end
