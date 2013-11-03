source 'https://rubygems.org'

ruby '2.0.0'

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem "non-stupid-digest-assets"

group :production do
  gem "pg"
  gem 'iron_cache_rails'

  gem 'newrelic_rpm'
end

gem 'rails', '4'
gem "twitter-bootstrap-rails"

gem 'jquery-rails'
gem 'gmaps4rails'
gem 'bootstrap-sass'
gem 'bourbon'
gem 'rails-backbone'
gem 'eco'
gem 'rack-rewrite', '~> 1.2.1'
#user authentication
gem 'devise', "~>3.0.3"
gem 'devise_invitable','~> 1.2.1'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-linkedin-oauth2', "0.0.2"

gem 'omnicontacts'
gem 'social-share-button'

gem 'thin'
gem "figleaf"

gem 'postmark-rails', "~>0.5.1"
gem "sentry-raven"

gem 'typhoeus'

gem 'activerecord-import', ">=0.4.0"
gem 'yaml_db'
gem 'protected_attributes'

gem 'nokogiri', "1.5.9"
gem 'roadie'

gem 'simple_form'
gem 'embedly'
gem 'acts-as-taggable-on'
gem 'cloudinary'
gem 'rabl'

gem 'responders', github: 'plataformatec/responders'
gem 'inherited_resources', github: 'josevalim/inherited_resources'
gem 'ransack'
gem 'activeadmin', github: 'gregbell/active_admin', branch: 'rails4'

gem 'rails_12factor'

gem 'redis'
gem 'rollout'

group :test, :development do
  gem "mysql2"
end

group :test do
  gem 'rspec-rails', '~> 2'
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
  gem "guard-bundler"
  gem 'guard-rspec', require: false
    # Guard and friends
  gem "guard"
  gem "guard-bundler"
  gem "guard-livereload"
  gem "guard-rspec"
  gem "guard-spork"
  gem "rb-fchange", require: false
  gem "rb-fsevent", require: false
  gem "rb-inotify", require: false
  gem "foreman"

  #show great looking error pages with extra functionality
  gem "better_errors"
  gem "binding_of_caller"

  #load rails much faster in development
  #gem 'rails-dev-boost', git: 'git://github.com/thedarkone/rails-dev-boost.git'
end

group :development, :test do
  gem 'quiet_assets'
  gem 'annotate', '>=2.5.0'
  gem 'faker'
  gem 'factory_girl_rails', '~> 4.0'

  gem "hirb"
  gem "hpricot"

  # Jasmin JS testing:
  gem 'guard-jasmine'
  gem 'jasmine'
  gem 'jasminerice', github: "bradphelan/jasminerice"
  gem 'jasmine-headless-webkit'
  gem 'poltergeist'

  #debugging
  gem "pry"
  gem "pry-debugger"
  gem 'email_preview'
  gem 'vcr'
  gem 'letter_opener'
end
