require_relative 'udacity_exe_spec_helper.rb'

describe 'Udacity executable files' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'should support help instruction' do
    result = help
    result.must_equal (UDACITY_RESULT['help'])
  end

  it 'should get all courses successfully' do
    result = action('all')
    result.nil?.must_equal false
  end

  it 'should get course by id successfully' do
    result = action('id', 'cs101')
    result.must_equal ( UDACITY_RESULT['get_course_by_id'] )
  end

  it 'should get course by title successfully' do
    result = action('title', 'Intro to Java Programming')
    result.must_equal ( UDACITY_RESULT['get_course_by_title'] )   
  end

  it 'should throw error message when given wrong command' do
    result = check_command_available('ttt')
    result.must_equal ( UDACITY_RESULT['error_command'] )  
  end

  it 'should throw error message when given wrong feature for id' do
    result = check_feature_available('ttt')
    result.must_equal ( UDACITY_RESULT['error_feature']['id'] )  
  end

  it 'should throw error message when given wrong feature for title' do
    result = check_feature_available('ttt')
    result.must_equal ( UDACITY_RESULT['error_feature']['title'] )  
  end  
end
