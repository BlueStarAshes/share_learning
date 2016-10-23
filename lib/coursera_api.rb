require 'http'
require 'json'

module Coursera
  # This class is in charge of the work involving using Coursera API
  class CourseraApi
    COURSERA_CATOLOG_API_URL = 'https://api.coursera.org/api/courses.v1'.freeze
    COURSERA_COURSE_LINK_BASE = 'https://www.coursera.org/learn/'.freeze
    BATCH_SIZE = 100

    attr_reader :total_course_num, :courses

    def initialize
    end

    def retrieve_total_course_num
      # Create an API response dump
      coursera_response = {}
      # Retrieve the total number of courses on the catlog
      course_start_num = 0
      course_num_limit = 0
      query_response =
        HTTP.get(COURSERA_CATOLOG_API_URL,
                 params: { start: course_start_num,
                           limit: course_num_limit })
      body_str = query_response.body.to_s
      coursera_response[:paging] = JSON.parse(body_str)['paging']
      coursera_response[:paging]['total']
    end

    def query_a_batch_of_courses(course_start_num, course_num_limit)
      # Create an API response dump
      retrieved_batch = {}
      query_response =
        HTTP.get(COURSERA_CATOLOG_API_URL,
                 params: { start: course_start_num,
                           limit: course_num_limit,
                           fields: 'description,photoUrl' })
      body_str = query_response.body.to_s
      retrieved_batch[:courses] = JSON.parse(body_str)['elements']
      retrieved_batch
    end

    def parse_batch_result(course_start_num, retrieved_batch)
      # Create an parsed dump
      parsed_courses = {}
      count = course_start_num
      retrieved_batch[:courses].each do |course|
        parsed_course = {}
        parsed_course[:course_type] = course['courseType']
        parsed_course[:course_id] = course['id']
        parsed_course[:course_slug] = course['slug']
        parsed_course[:course_name] = course['name']
        parsed_course[:link] =
          COURSERA_COURSE_LINK_BASE + course['slug']
        parsed_course[:description] = course['description']
        parsed_course[:photo_url] = course['photoUrl']
        parsed_courses[count] = parsed_course
        count += 1
      end
      parsed_courses
    end

    def retrieve_all_courses
      # Create an dump for retrieved courses
      retrieved_courses = {}
      # Set the relating numbers
      course_start_num = 0
      course_num_limit = 100
      total_course_num = retrieve_total_course_num
      number_of_batches = total_course_num / BATCH_SIZE
      number_of_batches += 1 unless (total_course_num % BATCH_SIZE).zero?
      # Retrieve courses batch by batch
      number_of_batches.times do
        # Jump out the loop if we know there is not any courses left
        break if course_start_num >= total_course_num
        # Use the API to get courses response on Coursera
        retrieved_batch =
          query_a_batch_of_courses(course_start_num, course_num_limit)
        # Parse the response to get the desired courses data
        retrieved_courses =
          retrieved_courses.merge(parse_batch_result(course_start_num, retrieved_batch))
        # Increase the course number to start with next batch
        course_start_num += BATCH_SIZE
      end
      retrieved_courses
    end
  end
end
