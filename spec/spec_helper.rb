$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'searchyll'

if ENV.fetch('GITHUB_ACTIONS', false) || ENV.fetch('COVER', false)
  require 'simplecov'
  SimpleCov.start
end
