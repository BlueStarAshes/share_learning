require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/coursera_courses.rb'

describe 'Coursera API specifications' do
  before do
    @coursera_api = Coursera::CourseraApi.new
  end
  it 'should be able to retrieve how many the courses are on the
      Coursera catlog' do
    # coursera_courses = Coursera::CourseraCourses.new(@coursera_api)
    coursera_courses = Coursera::CourseraCourses.find(@coursera_api)
    coursera_courses.total_course_num.must_be :>=, 0
  end
  it 'should be able to retrieve correct number of all courses' do
    # coursera_courses = Coursera::CourseraCourses.new(@coursera_api)
    coursera_courses = Coursera::CourseraCourses.find(@coursera_api)
    coursera_courses.courses.size.must_equal coursera_courses.total_course_num
  end
end
