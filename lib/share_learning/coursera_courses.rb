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
      courses = CourseraApi.courses
      new(total_course_num, courses)
    end

    def course_matched?(course, method, keyword)
      available_methods = [:course_name, :description]
      result = false
      available_methods.each do |m|
        next unless method == :all || m == method
        result = true if course[m].downcase.include?(keyword)
      end
      result
    end

    def search_courses(method, keyword)
      matched_courses = []
      @courses.size.times do |i|
        course = courses[i]
        matched_courses.push(course) if course_matched?(course, method, keyword)
      end
      matched_courses
    end

    def print_all_courses
      puts "#{@total_course_num} courses:"
      @courses.size.times do |i|
        print_course(@courses[i], i)
      end
    end

    def print_course(course, sequence_number)
      puts "Course #{sequence_number}:\n"\
           "\tTitle: #{course[:course_name]}\n"\
           "\tType: #{course[:course_type]}\n"\
           "\tID: #{course[:course_id]}\n"\
           "\tSlug: #{course[:course_slug]}\n"\
           "\tLink: #{course[:link]}\n"\
           "\tDescription: #{course[:description][0..100]}...\n"\
           "\tPhoto URL: #{course[:photo_url]}\n"\
           "\n"
    end

    private :print_course
  end
end
