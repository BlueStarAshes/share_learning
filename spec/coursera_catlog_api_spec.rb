require 'minitest/autorun'
require 'minitest/rg'

require '../lib/coursera_catalog_api.rb'

describe 'Coursera catlog API specifications' do
  before do
    @coursera_catlog_api = CourseraCatlogApi.new
  end
  it 'should be able to retrieve how many the courses are on the
      Coursera catlog' do
    @coursera_catlog_api.total_course_num.must_be :>=, 0
  end
  it 'should be able to retrieve correct number of all courses' do
    @coursera_catlog_api.courses.size.must_equal @coursera_catlog_api.total_course_num
  end
end
