# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'sqlite3', '~> 1.4'

group :test do
  gem 'shoulda-matchers', '~> 4.0'
end

group :development, :test do
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
