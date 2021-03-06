$:.unshift(File.dirname(__FILE__) + '/../lib')
RAILS_ROOT = File.dirname(__FILE__)

require 'logger'
require 'rubygems'
require 'yaml'
require 'active_model'
require 'active_model/validations'
require 'active_record'
require 'active_support/test_case'
require 'minitest/autorun'
require "#{File.dirname(__FILE__)}/../init"

ActiveSupport::TestCase.test_order = :random

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.establish_connection(config[ENV['DB'] || 'sqlite3'])

load(File.dirname(__FILE__) + "/schema.rb") if File.exist?(File.dirname(__FILE__) + "/schema.rb")

