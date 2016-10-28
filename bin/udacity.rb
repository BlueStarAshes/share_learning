#!/usr/bin/env ruby
# frozen_string_literal: true
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), *%w(.. lib))
require 'Share_learning'

course_id = ARGV[0]
unless course_id
  puts 'USAGE: udacity [course_id]'
  exit(1)
end

course = Udacity::UdacityCourse.find().acquire_course_by_id(course_id)

puts 'title: ' + course[:title]
puts 'introduction: ' + course[:intro]
puts 'link: ' + course[:link]
