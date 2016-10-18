require 'minitest/autorun'
require 'minitest/rg'
require 'json'

require '../lib/udacity_api.rb'

COURSE_DATA = JSON.parse(File.read('data/course_test_data.json'))

describe 'Udacity api' do
  it 'should get json response successfully' do
    udacity = UdacityAPI.new
    response = udacity.acquire_json_response
    response.nil?.must_equal false
  end

  it 'should get all courses successfully' do
    udacity = UdacityAPI.new
    response = udacity.acquire_json_response
    all_courses = udacity.get_all_courses(response)
    all_courses.nil?.must_equal false
  end

  it 'should get course by id successfully' do
    udacity = UdacityAPI.new
    response = udacity.acquire_json_response
    course = udacity.get_course_by_id(response, 'cs101')
    title = COURSE_DATA['course'][0]['get_course_by_id'][0]['title']
    homepage = COURSE_DATA['course'][0]['get_course_by_id'][0]['homepage']

    course.must_equal (title + "\nhomepage: " + homepage)
  end

  it 'should get course by title successfully' do
    udacity = UdacityAPI.new
    response = udacity.acquire_json_response
    course = udacity.get_course_by_title(response, 'Intro to Java Programming')
    title = COURSE_DATA['course'][0]['get_course_by_title'][0]['title']
    homepage = COURSE_DATA['course'][0]['get_course_by_title'][0]['homepage']

    course.must_equal (title + "\nhomepage: " + homepage)
  end

  it 'should get courses by level successfully' do
    udacity = UdacityAPI.new
    response = udacity.acquire_json_response
    course = udacity.get_course_by_level(response, 'beginner')
    course.nil?.must_equal false
  end

  it 'should get courses by tracks successfully' do
    udacity = UdacityAPI.new
    response = udacity.acquire_json_response
    course = udacity.get_course_by_tracks(response, 'Data Science')
    course.nil?.must_equal false
  end
end
