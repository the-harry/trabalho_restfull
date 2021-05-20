# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'

group :test do
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry', '~> 0.12.2'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'rubocop', require: false
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
