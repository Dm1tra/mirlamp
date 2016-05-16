source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
gem 'pg'
#gem 'rmagick'
#gem 'rmagick', '~> 2.15', '>= 2.15.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby, group: :production

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'spree_i18n', github: 'spree-contrib/spree_i18n', branch: '3-0-stable'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

gem 'redis-rails'
gem 'haml-rails'
gem 'spree', github: 'spree/spree', branch: '3-0-stable'
gem 'spree_gateway', github: 'spree/spree_gateway', branch: '3-0-stable'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '3-0-stable'
group :development do
  gem 'guard-livereload', '~> 2.4', require: false
  gem 'better_errors'
  gem 'guard-rspec', require: false
  gem 'quiet_assets'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano3-delayed-job', '~> 1.0', require: false
  # gem 'capistrano-spree', '~> 1.0.0'
  gem 'letter_opener'

  gem 'rails_real_favicon'
end
gem 'dotenv'
gem 'dotenv-deployment', require: 'dotenv/deployment'
gem 'puma'
gem 'rubocop', require: false
gem 'delayed_job_active_record'
gem 'daemons'
gem 'spree_sitemap', github: 'spree-contrib/spree_sitemap', branch: '3-0-stable'
gem 'spree_static_content', github: 'spree-contrib/spree_static_content', branch: '3-0-stable'
gem 'spree_slider', github: 'spree-contrib/spree_slider', branch: '3-0-stable'
gem 'whenever', require: false
gem 'httparty'
gem 'owlcarousel-rails'#, github: 'acrogenesis/owlcarousel-rails', branch: 'OwlCarousel2'
gem 'simple-spreadsheet'
gem 'mechanize'
gem 'selenium-webdriver'
group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', require: false
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'capybara-email'
  gem 'json_spec'
end

gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
