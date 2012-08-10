source 'http://rubygems.org'

gem 'rails'

gem 'less'
gem 'less-rails-bootstrap'
gem 'therubyracer'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'backbone-rails'
#gem 'backbone-forms-rails'
gem 'ejs'
gem 'jquery-rails'
gem "haml-rails"
gem 'coffee-filter'
gem 'rails-timeago'
gem 'friendly_id'
gem 'bluecloth'

gem 'pg'
gem 'bcrypt-ruby'

gem "nodevent"#, :path => '../nodevent/gem/nodevent'

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
  #gem 'capybara-webkit'

  #gem 'headless'
  #gem 'jasmine'
  #gem 'evergreen', :require => 'evergreen/rails'
#  gem 'jasminerice'
#  gem 'jasmine-headless-webkit'
end

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
  gem 'rr'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'fixture_builder'
end

group :production do
    gem 'unicorn'
end


