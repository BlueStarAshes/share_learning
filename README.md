
# share_learning
[![Gem Version](https://badge.fury.io/rb/Share_learning.svg)](https://badge.fury.io/rb/Share_learning)
[![Build Status](https://travis-ci.org/BlueStarAshes/Share_learning.svg?branch=master)](https://travis-ci.org/BlueStarAshes/Share_learning)   


## Introduction
`share_learning` is aimed to be a crowd sourcing open learning platform.

It collects courses links from MOOCS like Coursera, Udacity, Udemy, etc. and relating videos links on Youtube, and lets users easily find learning resources matching their familiarity to a want-to-learn subject / topic on just one website. Users can leave suggestions, tags, and ratings to each learning resource. They can also add relating learning resource links to each subject / topic.

But now it is still under construction. :sweat_smile: :beer:

## Installation
If you are working on a project, add this to your Gemfile: `gem 'share_learning'`

For ad hoc installation from command line:

`$ gem install share_learning`


## Setup Youtube Credentials
Please setup your YouTube credentials by create a project in the Google Developers Console: https://console.developers.google.com and obtain authorization credentials so your application can submit API requests. You should get a YouTube API key.
## Usage

### Coursera
#### Command line
To use `coursera` in command line, please type as the folling format:
`coursera [command] [keyword]`

`[command]` now includes `[title]`, and `[description]`.

* `[title]`
helps you search courses on Coursea with titles containing the `[keyword]` you give.

* `[description]`
helps you search courses on Coursea with descriptions  containing the `[keyword]` you give.


#### In your project
To use `coursera` in your project, `require 'share_learning'` in your code.

See the following code for more detail of the usage.
```ruby
# Access the courses on Coursera
courses = Coursera::CourseraCourses.find.courses

# Check how many courses there are on Coursera
total = Coursera::CourseraCourses.find.total_course_num

# Access each course's title, type, ID, Slug, link, description, and photo URL
courses.size.times do |i|
    course = courses[i]
    puts "Course #{sequence_number}:\n"\
         "\tTitle: #{course[:course_name]}\n"\
         "\tType: #{course[:course_type]}\n"\
         "\tID: #{course[:course_id]}\n"\
         "\tSlug: #{course[:course_slug]}\n"\
         "\tLink: #{course[:link]}\n"\
         "\tDescription: #{course[:description][0..100]}...\n"\
         "\tPhoto URL: #{course[:photo_url]}\n"\
         "\n"

# Search courses with titles or descriptions containing a given keyword
# results is an array of hash where each hash represents a course
results = Coursera::CourseraCourses.find.search_courses(:all, keyword)

# Search courses with titles containing a given keyword
results = Coursera::CourseraCourses.find.search_courses(:course_name, keyword)

# Search courses with descriptions containing a given keyword
results = Coursera::CourseraCourses.find.search_courses(:description, keyword)
end
```

### Udacity
Udacity application allows you to get the information includes title, introduction, link to the homepage and the image of the course. There are two ways to use the Udacity application:
#### Command line

BASIC USAGE: `udacity [command][feature]`  

`[command]` now includes `[help]`, `[all]`, `[id]`, `[title]` and `[search]`
 * `[help]`
    Give the introduction of how to use it.
 * `[all]`
   List all the courses on Udacity.
 * `[id]`
   Search a particular course on Udacity with the specific course id.
 * `[title]`
   Search a particular course on Udacity with the specific course title.
 * `[search]`
   Search courses on Udacity with the keyword.

`[feature]` is only needed when using the command`[id]`,`[title]` and `[search]`
 * If you're using the command `[id]`, then `[feature]` is the course id
 * If you're using the command `[title]`, then `[feature]` is the course title
 * If you're using the command `[search]`, then `[feature]` is the keyword you want to search
 * Example: `udacity id 'cs101'` or `udacity title 'Introduction to Virtual Reality'` or `udacity search 'java'`

#### In your project

First, `require 'Share_learning'` in your code.
See the following example code for more usage details:

```ruby
# Access courses data
courses = Udacity::UdacityCourse.find()

# Acquire all courses information
all_courses = courses.acquire_all_courses

# Acquire course information with a given course id
# example: courses.acquire_course_by_id('cs101')
get_course_by_id = courses.acquire_course_by_id(course_id)


# Acquire course information with a given course title
# # example: courses.acquire_course_by_title('Introduction to Virtual Reality')
get_course_by_id = courses.acquire_course_by_title(course_title)

```



### YouTube
#### Command line
* Setup environment variables: `ENV[YOUTUBE_API_KEY]`
* USAGE: `youtube [keyword]`   
    * `[keyword]` - helps you search and get information of playlists on YouTube.

#### In your project
* `require 'Share_learning'`     
See the following example code for more usage details:     
```ruby
# Access playlists data
playlist_data = YouTube::YouTubePlaylist.find(keyword: 'keyword')
playlist_data.results.each.with_index do |playlist, index|
  print "#{index + 1}. "
  puts "Playlist on YouTube: #{playlist['title']}"
  puts "Description: #{playlist['description']}"
  puts "Image: #{playlist['image']}"
  puts "URL: #{playlist['url']}"
  puts
end
```
