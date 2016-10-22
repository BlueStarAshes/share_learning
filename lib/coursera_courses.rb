require_relative 'coursera_api'

module Coursera
  # This class is for Coursera courses
  class CourseraCourses
    attr_reader :total_course_num, :courses

    def initialize(coursera_api, total_course_num, courses)
      @coursera_api = coursera_api
      @total_course_num = total_course_num
      @courses = courses
    end

    def self.find(coursera_api)
      total_course_num = coursera_api.retrieve_total_course_num
      courses = coursera_api.retrieve_all_courses
      new(coursera_api, total_course_num, courses)
    end

    def print_all_courses
      puts "#{@total_course_num} courses:"
      count = 0
      @courses.size.times do
        course = @courses[count]
        puts "Course #{count}:"
        puts "\tTitle: #{course[:course_name]}"
        puts "\tType: #{course[:course_type]}"
        puts "\tID: #{course[:course_id]}"
        puts "\tSlug: #{course[:course_slug]}"
        puts "\tLink: #{course[:link]}"
        puts "\tDescription: #{course[:description]}"
        puts "\tPhoto URL: #{course[:photo_url]}"
        puts
        count += 1
      end
    end
  end
end
