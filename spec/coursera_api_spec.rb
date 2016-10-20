require 'minitest/autorun'
require 'minitest/rg'

require '../lib/coursera_api.rb'

describe 'Coursera API specifications' do
  before do
    @coursera_api = Coursera::CourseraApi.new
  end
  it 'should be able to retrieve how many the courses are on the
      Coursera catlog' do
    @coursera_api.total_course_num.must_be :>=, 0
  end
  it 'should be able to retrieve correct number of all courses' do
    @coursera_api.courses.size.must_equal @coursera_api.total_course_num
  end
end
