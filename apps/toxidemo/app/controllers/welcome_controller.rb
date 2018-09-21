require 'redis'
require 'toxiproxy'

class WelcomeController < ApplicationController
  def index
    config.logger = Logger.new(STDOUT)
  
    redis = Redis.new(port: 6379)
    logger.info redis.get('test')
  end
end
