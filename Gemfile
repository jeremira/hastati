# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Core
ruby '2.7.1'
gem 'activeadmin', '~> 2.8'
gem 'devise', '~> 4.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.3'

# Front
gem 'sass-rails', '~> 6.0'
gem 'turbolinks', '~> 5.2'
gem 'webpacker', '~> 5.2'

# Misc
gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.10'

group :development, :test do
  gem 'bullet'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'factory_bot_rails', '~> 5.2'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop', '~> 0.92', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'webdrivers', '~> 4.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
