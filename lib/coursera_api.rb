require 'http'
require 'json'

module Coursera
  # This class is in charge of the work involving using Coursera API
  class CourseraApi
    COURSERA_CATOLOG_API_URL = 'https://api.coursera.org/api/courses.v1'.freeze
    BATCH_SIZE = 100

    attr_reader :total_course_num, :courses

    def initialize
      # Create an API response dump
      @coursera_response = {}
      # Create an dump for all courses
      @courses = {}
      retrieve_total_course_num
      retrieve_all_courses_info
      print_all_courses
    end

    def retrieve_total_course_num
      # Retrieve the total number of courses on the catlog
      course_start_num = 0
      course_num_limit = 0
      query_response =
        HTTP.get(COURSERA_CATOLOG_API_URL,
                 params: { start: course_start_num,
                           limit: course_num_limit })
      body_str = query_response.body.to_s
      @coursera_response[:paging] = JSON.parse(body_str)['paging']
      @total_course_num = @coursera_response[:paging]['total']
    end

    def query_a_batch_of_courses(course_start_num, course_num_limit)
      query_response =
        HTTP.get(COURSERA_CATOLOG_API_URL,
                 params: { start: course_start_num,
                           limit: course_num_limit })
      body_str = query_response.body.to_s
      @coursera_response[:elements] = JSON.parse(body_str)['elements']
    end

    def parse_batch_result(course_start_num)
      count = course_start_num
      @coursera_response[:elements].each do |element|
        @courses[count] = {}
        @courses[count][:course_type] = element['courseType']
        @courses[count][:course_id] = element['id']
        @courses[count][:course_slug] = element['slug']
        @courses[count][:course_name] = element['name']
        count += 1
      end
    end

    def print_all_courses
      puts "#{@total_course_num} courses:"
      count = 0
      @courses.size.times do
        puts "Course #{count}: #{@courses[count][:course_name]}"
        puts "\tType: #{@courses[count][:course_type]}"
        puts "\tID: #{@courses[count][:course_id]}"
        puts "\tSlug: #{@courses[count][:course_slug]}"
        puts
        count += 1
      end
    end

    def retrieve_all_courses_info
      course_start_num = 0
      course_num_limit = 100
      number_of_batches = total_course_num / BATCH_SIZE
      number_of_batches += 1 unless (total_course_num % BATCH_SIZE).zero?
      number_of_batches.times do
        # Jump out the loop if we know there is not any courses left
        break if course_start_num >= total_course_num
        # Use the API to get courses response on Coursera
        query_a_batch_of_courses(course_start_num, course_num_limit)
        # Parse the response to get the desired courses data
        parse_batch_result(course_start_num)
        # Increase the course number to start with next batch
        course_start_num += BATCH_SIZE
      end
    end
  end
end
