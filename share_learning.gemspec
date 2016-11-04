# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'Share_learning/share_learning_version'

Gem::Specification.new do |s|
  s.name        =  'share_learning'
  s.version     =  ShareLearning::VERSION

  s.summary     =  'Gets learning resource from Coursera, Udacity, and Youtube.'
  s.description =  'Extracts course\'s titles, descriptions, images and links '\
                   'from Coursera and Udacity. '\
                   'And searches relating resource on Youtube.'
  s.authors     =  ['ashleycheng, blureze, meegoStar']
  s.email       =  ['ashley830204@gmail.com', 'blureze@gmail.com', 'andy19933@gmail.com']

  s.files       =  `git ls-files`.split("\n")
  s.test_files  =  `git ls-files -- spec/*`.split("\n")
  s.executables << 'udacity' << 'coursera' << 'youtube'

  s.add_runtime_dependency 'http', '~> 2.0'

  s.add_development_dependency 'minitest', '~> 5.9'
  s.add_development_dependency 'minitest-rg', '~> 5.2'
  s.add_development_dependency 'rake', '~> 11.2'
  s.add_development_dependency 'vcr', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 2.1'
  s.add_development_dependency 'simplecov', '~> 0.12'
  s.add_development_dependency 'flog', '~> 4.4'
  s.add_development_dependency 'flay', '~> 2.8'
  s.add_development_dependency 'rubocop', '~> 0.44'
  s.homepage    =  'https://github.com/BlueStarAshes/Share_learning'
  s.license     =  'MIT'
end
