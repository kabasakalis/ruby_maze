# require 'codeclimate-test-reporter'
# CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler/setup'
Bundler.setup

require 'thor'
require 'pry'
require 'maze'

require 'maze/version'
# require 'maze/canvas'
require 'maze/room'
require 'maze/maze'
require 'maze/builder'
require 'maze/solver'
# require 'helpers/thor.rb'

RSpec.configure do |_config|
  # some (optional) config here
end
