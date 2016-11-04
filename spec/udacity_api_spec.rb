require_relative 'udacity_api_spec_helper.rb'

describe 'Udacity course' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes

    @udacity_api = Udacity::UdacityAPI
  end

  after do
    VCR.eject_cassette
  end

  it 'should get json response successfully' do
    udacity = Udacity::UdacityAPI.acquire_json_response
    udacity.nil?.must_equal false
  end

  it 'should get all courses successfully' do
    udacity = Udacity::UdacityCourse.find()
    all_courses = udacity.acquire_all_courses
    all_courses.nil?.must_equal false
  end

  it 'should get course by id successfully' do
    udacity = Udacity::UdacityCourse.find()
    course = udacity.acquire_course_by_id('cs101')
    course.must_equal ( UDACITY_RESULT[:get_course_by_id] )
  end

  it 'should get course by title successfully' do
    udacity = Udacity::UdacityCourse.find()
    course = udacity.acquire_course_by_title('Intro to Java Programming')
    course.must_equal ( UDACITY_RESULT[:get_course_by_title] )   
  end

  it 'should get course by keywords successfully' do
    udacity = Udacity::UdacityCourse.find()
    course = udacity.acquire_courses_by_keywords('Java Programming')
    course.nil?.must_equal false
  end

  it 'should get the number of course successfully' do
    udacity = Udacity::UdacityCourse.find()
    udacity.total_course_num.must_be :>=, 0
  end

  # it 'should get courses by level successfully' do
  #   udacity = Udacity::UdacityCourse.find()
  #   course = udacity.acquire_courses_by_level('beginner')
  #   course.nil?.must_equal false
  # end

  # it 'should get courses by tracks successfully' do
  #   udacity = Udacity::UdacityCourse.find()
  #   course = udacity.acquire_courses_by_tracks('Data Science')
  #   course.nil?.must_equal false
  # end
end
