require_relative 'spec_helper.rb'

describe 'Udacity course' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes

    @udacity_api = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
  end

  after do
    VCR.eject_cassette
  end

  it 'should get json response successfully' do
    udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    udacity.json_response.nil?.must_equal false
  end

  it 'should get all courses successfully' do
    # udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    all_courses = @udacity_api.acquire_all_courses
    all_courses.nil?.must_equal false
  end

  it 'should get course by id successfully' do
    # udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    course = @udacity_api.acquire_course_by_id('cs101')
    course.must_equal ( UDACITY_RESULT[:get_course_by_id] )
  end

  it 'should get course by title successfully' do
    # udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    course = @udacity_api.acquire_course_by_title('Intro to Java Programming')
    course.must_equal ( UDACITY_RESULT[:get_course_by_title] )   
  end

  it 'should get courses by level successfully' do
    # udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    course = @udacity_api.acquire_courses_by_level('beginner')
    course.nil?.must_equal false
  end

  it 'should get courses by tracks successfully' do
    # udacity = Udacity::UdacityCourse.new(Udacity::UdacityAPI.new)
    course = @udacity_api.acquire_courses_by_tracks('Data Science')
    course.nil?.must_equal false
  end
end
