source 'https://rubygems.org'

ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.5'
gem "haml", ">= 3.1.5"
gem "haml-rails", ">= 0.3.4"
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
#gem 'therubyracer', platforms: :ruby, :group => :digitalocean #WHY WAS THIS REMOVED? IT"S NEEDED FOR PRODUCTION ??

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

#RailsConfig helps you easily manage environment specific Rails settings in an easy and usable manner
gem "rails_config", "~> 0.3.3"
# Using devise gem for auth
gem 'devise'

gem "paperclip", "~> 4.1"

# For load all javascript. Read more: http://stackoverflow.com/questions/17881384/jquery-gets-loaded-only-on-page-refresh-in-rails-4-application
gem 'jquery-turbolinks'

gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'
# For pagination
gem 'kaminari'
gem 'nokogiri', '~> 1.6.2.1'
gem 'icalendar'
gem 'browser'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'mail'
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# For production environment
group :production do
  gem 'rails_12factor'
  gem 'therubyracer', platforms: :ruby
  gem 'mysql2'
end

# For heroku environment
group :preview do
  gem 'pg'
end

# For staging environment
group :staging do
  gem 'mysql2'
end

# For development environment
group :development do
  gem 'sextant'
  gem 'sqlite3'
  gem 'pry'
  gem "letter_opener"
  gem 'pg'
end