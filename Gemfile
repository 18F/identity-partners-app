source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'administrate', '>= 0.14.0'
gem 'devise', '~> 4.7', '>= 4.7.3'
gem 'figaro'
gem 'pg'
gem 'rails', '~> 6.0', '>= 6.0.3.5'
gem 'sass-rails', '>= 6.0.0'
gem 'simple_form', '~> 5.0', '>= 5.0.3'

gem 'omniauth_login_dot_gov', git: 'https://github.com/18f/omniauth_login_dot_gov.git'
gem 'pundit', '~> 2.1'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.2', '>= 5.2.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.8', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.0.4'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

group :test do
  gem 'capybara', '>= 3.33.0'
  gem 'selenium-webdriver'
  gem 'rspec-rails', '>= 4.0.1'
  gem 'shoulda-matchers'
  gem 'webdrivers', '>= 4.4.1'
end

group :development, :test do
  gem 'factory_bot_rails', '>= 6.1.0'
  gem 'faker'
  gem 'puma'
end
