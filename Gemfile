source 'http://rubygems.org'

gem 'rails'
gem 'twitter'
gem 'tweetstream'
gem 'oauth'
gem 'eventmachine'
gem 'em-http-request'
gem 'yajl-ruby'
gem 'less'
gem 'less-rails-bootstrap'
gem 'therubyracer'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'backbone-rails'
gem 'ejs'
gem 'jquery-rails'
gem "haml-rails"

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem "nodevent"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'haml_coffee_assets'
  gem 'uglifier'
  gem 'jquery-ui-rails'
  gem 'i18n'
end


group :development do
    # Deploy with Capistrano
    gem 'capistrano'
    gem 'capistrano-ext'
    gem 'capistrano-unicorn'
    gem 'rvm-capistrano'
end

# Gemfile
group :development, :test do
  gem 'capybara-webkit'

  gem 'jasmine-rails'
  #gem 'evergreen', :require => 'evergreen/rails'
#  gem 'jasminerice'
#  gem 'jasmine-headless-webkit'
end

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end

group :production do
    gem 'unicorn'
end


