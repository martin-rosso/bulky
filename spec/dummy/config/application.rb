ENV['BUNDLE_GEMFILE'] = File.expand_path('../../../../Gemfile', __FILE__)

require 'rubygems'
require 'bundler'

Bundler.setup

# for everything: require "rails/all"
require "action_controller/railtie"
require "active_record/railtie"
require "active_job/railtie"
require "action_view/railtie"

Bundler.require

module Dummy
  class Application < ::Rails::Application
    config.cache_classes = true
    config.active_support.deprecation = :stderr
    config.secret_key_base = 'http://s3-ec.buzzfed.com/static/enhanced/webdr03/2013/5/25/8/anigif_enhanced-buzz-11857-1369483324-0.gif'
    config.eager_load = false
    config.action_controller.allow_forgery_protection    = false
    config.active_job.queue_adapter = :test


    # Raise exceptions instead of rendering exception templates
    config.action_dispatch.show_exceptions = false
    # because this belongs here for some reason...??? also in spec_helper
    # thanks rails 5 :/
    config.active_support.test_order = :random
  end
end

Dummy::Application.initialize!

# controllers
ApplicationController = Class.new(ActionController::Base) do
  protect_from_forgery with: :exception
end

# models
class Account < ActiveRecord::Base
  extend Bulky::Model
  bulky :business, :contact, :last_contracted_on

  validates :business, presence: true
end
