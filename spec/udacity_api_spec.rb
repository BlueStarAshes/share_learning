require 'minitest/autorun'
require 'minitest/rg'
require 'json'

require '../lib/udacity_course.rb'

COURSE_DATA = JSON.parse(File.read('data/course_test_data.json'), :symbolize_names => true)

describe 'Udacity course' do
  it 'should get json response successfully' do
    udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    udacity.json_response.nil?.must_equal false
  end

  it 'should get all courses successfully' do
    udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    all_courses = udacity.acquire_all_courses
    all_courses.nil?.must_equal false
  end

  it 'should get course by id successfully' do
    udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    course = udacity.acquire_course_by_id('cs101')
    course.must_equal ( COURSE_DATA[:get_course_by_id] )
  end

  it 'should get course by title successfully' do
    udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    course = udacity.acquire_course_by_title('Intro to Java Programming')
    course.must_equal ( COURSE_DATA[:get_course_by_title] )   
  end

  it 'should get courses by level successfully' do
    udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    course = udacity.acquire_courses_by_level('beginner')
    course.nil?.must_equal false
  end

  it 'should get courses by tracks successfully' do
    udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    course = udacity.acquire_courses_by_tracks('Data Science')
    course.nil?.must_equal false
  end
end
