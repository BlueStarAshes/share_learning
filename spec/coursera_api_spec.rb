require_relative 'coursera_api_spec_helper'

describe 'Coursera API specifications' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes
    @coursera_api = Coursera::CourseraApi.new
  end

  after do
    VCR.eject_cassette
  end

  it 'should be able to retrieve how many the courses are on the
      Coursera catlog' do
    coursera_courses = Coursera::CourseraCourses.find(@coursera_api)
    coursera_courses.total_course_num.must_be :>=, 0
  end

  it 'should be able to retrieve correct number of all courses' do
    coursera_courses = Coursera::CourseraCourses.find(@coursera_api)
    coursera_courses.courses.size.must_equal coursera_courses.total_course_num
  end
end
