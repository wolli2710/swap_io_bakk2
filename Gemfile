source 'https://rubygems.org'

gem 'rails', '3.2.1'
gem 'jquery-rails'
gem 'mysql2'
gem 'i18n_routing'
gem 'paperclip', '~> 2.5'
gem 'client_side_validations', :git => 'https://github.com/bcardarella/client_side_validations.git'

gem 'devise', '2.0.0'
gem 'omniauth-facebook'

gem 'activeadmin'

gem 'haml'

gem "airbrake"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
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
  gem 'factory_girl', '~> 2.6.1'
  gem 'shoulda'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'mocha'
  gem 'mynyml-redgreen'
  gem 'simplecov'
end
