source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

# Core gems
gem 'rails', '~> 6.1'
gem 'puma', '5.6.9'
# gem install mysql2 -v '0.5.4' -- --with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include
# gem install mysql2 -v '0.5.6' -- --with-mysql-dir=/opt/homebrew/bin/mysql --with-mysql-lib=/opt/homebrew/Cellar/mysql/8.3.0/lib --with-mysql-include=/opt/homebrew/Cellar/mysql/8.3.0/include/mysql
gem 'mysql2', '~> 0.5.6'
gem 'bootsnap', '~> 1.8', '>= 1.8.1', require: false

# Frontend
gem 'sass-rails', '~> 6.0'
gem 'webpacker', '~> 5.4', '>= 5.4.2'
gem 'turbolinks', '~> 5.2', '>= 5.2.1'

# Authentication & Admin
gem 'devise', '~> 4.8'
gem 'activeadmin', '~> 3.2'

# Utilities
gem 'money-rails', '~> 1.14'
gem 'country_select', '~> 6.0'
gem 'dump', '~> 1.2', '>= 1.2.2'
gem 'google-cloud-storage', '~> 1.34', '>= 1.34.1', require: false
gem 'skylight'
gem 'sd_notify'
gem 'turnout', '~> 2.5'

# Ruby 3.1 compatibility gems
gem 'matrix', '~> 0.4.2', require: false
gem 'net-imap', require: false
gem 'net-pop', require: false
gem 'net-smtp', require: false

group :development, :test do
  gem 'rspec-rails', '~> 5.0', '>= 5.0.2'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.23'
  gem 'pry-byebug', '~> 3.9'
  gem 'pry-rails', '~> 0.3.9'
  gem 'standard'
end

group :development do
  # Debug & Development Tools
  gem 'web-console', '~> 4.1'
  gem 'better_errors', '~> 2.9', '>= 2.9.1'
  gem 'annotate', '~> 3.1', '>= 3.1.1'
  gem 'letter_opener_web', '~> 1.4'
  gem 'listen', '~> 3.7'
  gem 'spring', '~> 3.0'

  # Deployment
  gem 'capistrano', '~> 3.16', require: false
  gem 'capistrano-asdf', require: false
  gem 'capistrano-rails', '~> 1.6', '>= 1.6.1', require: false
end

group :test do
  # Testing Framework
  gem 'capybara', '~> 3.35', '>= 3.35.3'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 5.2'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

# Windows/JRuby compatibility
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
