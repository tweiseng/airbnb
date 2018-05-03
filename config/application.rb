require_relative 'boot'

require 'rails/all'

require 'carrierwave'

require 'carrierwave/orm/activerecord' 

require 'mini_magick'

require 'fog/aws'

# require 'letter_opener'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Airbnb
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

# config.action_mailer.default_url_options = { host: 'localhost:3000' }
