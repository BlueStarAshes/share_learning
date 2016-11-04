require_relative 'coursera_api_spec_helper'

describe 'Coursera API specifications' do
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

  it 'should be able to retrieve how many the courses are on the
      Coursera catlog' do
    coursera_courses = Coursera::CourseraCourses.find
    coursera_courses.total_course_num.must_be :>=, 0
  end

  it 'should be able to retrieve correct number of all courses' do
    coursera_courses = Coursera::CourseraCourses.find
    coursera_courses.courses.size.must_equal coursera_courses.total_course_num
  end

  it 'should be able to search related courses with the given keyword' do
    keyword = 'machine learning'

    matched_courses =
      Coursera::CourseraCourses.find.search_courses(:all, keyword)
    matched_courses.count.must_be :>, 0

    matched_courses_by_title =
      Coursera::CourseraCourses.find.search_courses(:course_name, keyword)
    matched_courses_by_title.count.must_be :>, 0

    matched_courses_by_description =
      Coursera::CourseraCourses.find.search_courses(:description, keyword)
    matched_courses_by_description.count.must_be :>, 0

    matched_courses.count.must_be :>=, matched_courses_by_title.count
    matched_courses.count.must_be :>=, matched_courses_by_description.count
    sum = matched_courses_by_title.count + matched_courses_by_description.count
    matched_courses.count.must_be :<=, sum
  end
end
