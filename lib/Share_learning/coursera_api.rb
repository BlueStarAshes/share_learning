require 'http'
require 'json'

module Coursera
  # This class is in charge of the work involving using Coursera API
  class CourseraApi
    COURSERA_CATOLOG_API_URL = 'https://api.coursera.org/api/courses.v1'.freeze
    COURSERA_COURSE_LINK_BASE = 'https://www.coursera.org/learn/'.freeze
    BATCH_SIZE = 100

    def self.total_course_num
      @total_course_num = retrieve_total_course_num
    end

    def self.courses
      return @courses if @courses
      @courses = retrieve_all_courses
    end

    def self.retrieve_total_course_num
      return @total_course_num if @total_course_num
      # Retrieve the total number of courses on the catlog
      course_start_num = 0
      course_num_limit = 0
      query_response =
        HTTP.get(COURSERA_CATOLOG_API_URL,
                 params: { start: course_start_num,
                           limit: course_num_limit })
      JSON.parse(query_response.body.to_s)['paging']['total']
    end

    def self.retrieve_all_courses
      # Create an dump for retrieved courses
      retrieved_courses = {}
      # Set the relating numbers
      batch_start = 0
      # Retrieve courses batch by batch
      number_of_batches.times do
        # Jump out the loop if we know there is not any courses left
        break if batch_start >= @total_course_num

        retrieved_courses = new_batch_merged(retrieved_courses, batch_start)
        # Increase the course number to start with next batch
        batch_start += BATCH_SIZE
      end
      retrieved_courses
    end

    def self.number_of_batches
      result = retrieve_total_course_num / BATCH_SIZE
      result += 1 unless (@total_course_num % BATCH_SIZE).zero?
      result
    end

    def self.new_batch_merged(retrieved_courses, course_start)
      # Use the API to get courses response on Coursera
      retrieved_batch =
        query_a_batch_of_courses(course_start)
      # Parse the response to get the desired courses data
      parsed_batch = parse_batch_result(course_start, retrieved_batch)
      # Merge the parsed batch of courses
      retrieved_courses.merge(parsed_batch)
    end

    def self.query_a_batch_of_courses(course_start)
      # Create an API response dump
      retrieved_batch = {}
      query_response =
        HTTP.get(COURSERA_CATOLOG_API_URL,
                 params: { start: course_start,
                           limit: BATCH_SIZE,
                           fields: 'description,photoUrl' })
      body_str = query_response.body.to_s
      retrieved_batch[:courses] = JSON.parse(body_str)['elements']
      retrieved_batch
    end

    def self.parse_batch_result(course_start, retrieved_batch)
      # Create an parsed dump
      parsed_courses = {}
      count = course_start
      retrieved_batch[:courses].each do |course|
        parsed_courses[count] = parse_course(course)
        count += 1
      end
      parsed_courses
    end

    def self.parse_course(course)
      parsed_course = {}
      parsed_course[:course_type] = course['courseType']
      parsed_course[:course_id] = course['id']
      parsed_course[:course_slug] = course['slug']
      parsed_course[:course_name] = course['name']
      parsed_course[:link] =
        COURSERA_COURSE_LINK_BASE + course['slug']
      parsed_course[:description] = course['description']
      parsed_course[:photo_url] = course['photoUrl']
      parsed_course
    end

    private_class_method :retrieve_total_course_num
    private_class_method :retrieve_all_courses
    private_class_method :number_of_batches
    private_class_method :new_batch_merged
    private_class_method :query_a_batch_of_courses
    private_class_method :parse_batch_result
    private_class_method :parse_course
  end
end
