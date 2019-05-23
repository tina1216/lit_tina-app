require 'bundler'
Bundler.require

require './app'

Dotenv.load

Cloudinary.config do |config|
  config.cloud_name = 'dahbhemgv'
  config.api_key    = '684554412932741'
  config.api_secret = '192qoUFrhvDJz0vpWZpRGNLJs-U'
end

run Sinatra::Application