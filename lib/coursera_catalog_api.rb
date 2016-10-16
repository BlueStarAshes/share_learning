require 'http'
require 'json'

# Create an API response dump
coursera_response = {}

# Ask user to input a query word
puts 'Input the desired course number to start retrieving from:'
course_start_num = gets.chomp!.to_i
puts 'Input the desired number of courses to retrieve:'
course_num_limit = gets.chomp!.to_i

# Retrieve the courses batch by batch
total_course_num_unset = true
total_course_num = -1
batch_size = 100
number_of_batches = course_num_limit / batch_size
number_of_batches += 1 unless (course_num_limit % batch_size).zero?
number_of_batches.times do
  # Jump out the loop if we know there is not any courses left
  unless total_course_num_unset
    break if course_start_num >= total_course_num
  end

  # Use the API to get courses response on Coursera
  query_response =
    HTTP.get('https://api.coursera.org/api/courses.v1?start=300&limit=10',
             params: { start: course_start_num,
                       limit: course_num_limit })
  body_str = query_response.body.to_s
  coursera_response[:elements] = JSON.parse(body_str)['elements']
  coursera_response[:paging] = JSON.parse(body_str)['paging']
  coursera_response[:linked] = JSON.parse(body_str)['linked']

  # Adjust the course number limit according to the total number of courses
  # reponded by Coursera
  if total_course_num_unset
    total_course_num = coursera_response[:paging]['total']
    total_course_num_unset = false
  end

  # Parse the response to get the desired courses data
  puts "\nCourses from #{course_start_num} to "\
       "#{course_start_num + batch_size - 1}:"
  count = course_start_num
  coursera_response[:elements].each do |element|
    course_type = element['courseType']
    course_id = element['id']
    course_slug = element['slug']
    course_name = element['name']

    puts "Course #{count}: #{course_name}"
    puts "\tType: #{course_type}"
    puts "\tID: #{course_id}"
    puts "\tSlug: #{course_slug}"
    puts

    count += 1
  end

  # Increase the course number to start with next batch
  course_start_num += batch_size
end

puts "Total number of courses on Coursera: #{total_course_num}"
