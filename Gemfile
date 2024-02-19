source "https://rubygems.org"

gem "rails", "~> 6.0.0"
gem "bootsnap"
gem "sprockets", "< 4"

gem "sqlite3"
gem "pg"

gem "sass-rails"

gem "uglifier"
gem "coffee-rails"
gem "jquery-rails"

gem "slim-rails"

gem "rails-i18n"

gem "devise"
gem "devise-i18n"

gem "simple_form"

# Phone validation
gem "phony", "~> 2.15.11"
gem "phony_rails"

# Picture uploads
gem "carrierwave"
# gem 'rmagick'
gem "mini_magick"

gem "refile", git: "https://github.com/refile/refile", require: ["refile/rails", "refile/simple_form"]
gem "refile-mini_magick"
gem "image_processing"

gem "puma", group: :production

gem "globalize"

gem "yaml_db"

gem "bootstrap-sass"
gem "bootstrap-sass-extras"
gem "bootswatch-rails"
gem "autoprefixer-rails"
gem "font-awesome-sass", "~> 4.6.2"

gem "nested_form"
gem "jquery-datatables-rails"
gem "morrisjs-rails"
gem "raphael-rails"

gem "copy_carrierwave_file"

gem "jbuilder"

gem "search_object"

gem "faraday"

gem "rqrcode"

gem "draper"

gem "icalendar", require: ['icalendar', 'icalendar/tzinfo']

group :development do
  gem "spring"
  gem "spring-commands-rspec"
  gem "guard-rspec" # Continuous testing with Guard
  gem "rails-erd"
  gem "pry-rails"
  # gem 'hirb'
  gem "awesome_print"
  gem "capistrano"
  gem "capistrano-rails"
  gem 'capistrano-rvm'
  gem "capistrano3-puma"
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem "rspec-rails"
  gem "faker"
  gem "capybara"
  gem "selenium-webdriver"

  gem "byebug"
  gem "simplecov"
  gem "i18n-tasks"

  gem "delorean"

  gem "standard"
end

group :test do
  gem "database_cleaner"
  gem "factory_bot_rails"
end
