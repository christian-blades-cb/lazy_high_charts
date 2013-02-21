# coding: utf-8
require 'rubygems'
require 'bundler'
Bundler.setup

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/lazy_high_charts'))
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/lazy_high_charts/layout_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/lazy_high_charts/options_key_filter'))

require 'webrat'
require 'rspec'

# RSpec 1.x and 2.x compatibility
if defined?(RSpec)
  RSPEC_NAMESPACE = RSPEC_CONFIGURER = RSpec
elsif defined?(Spec)
  RSPEC_NAMESPACE = Spec
  RSPEC_CONFIGURER = Spec::Runner
else
  begin
    require 'rspec'
    RSPEC_NAMESPACE = RSPEC_CONFIGURER = Rspec
  rescue LoadError
    require 'spec'
    RSPEC_NAMESPACE = Spec
    RSPEC_CONFIGURER = Spec::Runner
  end
end

RSPEC_CONFIGURER.configure do |config|
  config.include Webrat::Matchers
end

module HighChartsHelper

end
