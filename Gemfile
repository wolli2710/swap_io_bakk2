source 'https://rubygems.org'

gem 'rails', '3.2.1'
gem 'jquery-rails'
gem 'mysql2'

gem 'devise', '2.0.0'
gem 'omniauth-facebook'

gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
  gem "twitter-bootstrap-rails", "~> 2.0rc0"
end

group :development do
  gem 'haml-rails'
  gem 'capistrano'
  #gem 'ruby-debug19', :require => 'ruby-debug'
end

group :production do
  gem 'unicorn'
end

group :test do
  gem 'factory_girl'
  gem 'shoulda'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'mocha'
end