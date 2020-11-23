source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'dry-monads', '~> 1.3.0'
gem 'hiredis', '~> 0.6.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'sidekiq', '~> 5.2.9'
gem 'sidekiq-statistic', '~> 1.4.0'
gem 'active_model_serializers', '~> 0.10.0'
gem 'pagy', '~> 3.9.0'

# Delivery providers #
gem 'sparkpost_rails', '~> 1.5.3'
gem 'mailgun-ruby', '~> 1.1.6'
gem 'aws-ses', '~> 0.7.0', require: 'aws/ses'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'solargraph', '~> 0.39.0'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
