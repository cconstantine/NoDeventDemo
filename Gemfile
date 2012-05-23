source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'tweetstream'
gem 'oauth'
gem 'eventmachine'
gem 'em-http-request'
gem 'yajl-ruby'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem "nodevent"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end


group :development do
    # Deploy with Capistrano
    gem 'capistrano'
    gem 'capistrano-ext'
    gem 'capistrano-unicorn'
    gem 'rvm-capistrano'
end

group :production do
    gem 'unicorn'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end
