source 'https://rubygems.org'

ruby '2.0.0'

group :assets do
  gem 'sass-rails', '~> 3.2'
  gem 'coffee-rails', '~> 3.2'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem "pg"
  gem 'iron_cache_rails'

  gem 'newrelic_rpm'
end

gem 'rails', '~> 3.2'
gem "twitter-bootstrap-rails"

gem 'jquery-rails'
gem 'gmaps4rails'
gem 'bootstrap-sass'
gem 'rails-backbone'
gem 'eco'

#user authentication
gem 'devise', '~> 2'
gem 'devise_invitable'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-linkedin-oauth2'

gem 'omnicontacts'
gem 'social-share-button'

gem 'thin'
gem "figleaf"

gem 'postmark-rails', "~>0.5.1"
gem "sentry-raven"

gem 'typhoeus'

gem 'activerecord-import'
gem 'strong_parameters'

gem 'nokogiri', "1.5.9"
gem 'roadie'

gem 'simple_form'
gem 'embedly'
gem 'acts-as-taggable-on'
gem 'cloudinary'

group :test, :development do
  gem "mysql2"
end

group :test do
  gem 'faker'
  gem 'rspec-rails', '~> 2'
  gem 'factory_girl', '~> 3'
  gem 'factory_girl_rails'
  gem 'webrat'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'pickle'
  gem 'launchy'
  gem 'rspec-mocks'
  gem 'shoulda-matchers'
end

group :development do
  gem "guard"
  gem "guard-migrate"
  gem "foreman"
  gem 'quiet_assets'

  #show great looking error pages with extra functionality
  gem "better_errors"
  gem "binding_of_caller"

  #load rails much faster in development
  gem 'rails-dev-boost', git: 'git://github.com/thedarkone/rails-dev-boost.git'
end

group :development, :test do
  gem "hirb"
  gem "hpricot"
  
  # Jasmin JS testing:
  gem 'guard-jasmine'
  gem 'jasmine'
  gem 'jasminerice'
  gem 'jasmine-headless-webkit'

  #debugging
  gem "pry"
  gem "pry-debugger"
  gem 'email_preview'
  gem 'vcr'
end
