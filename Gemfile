source :gemcutter
source 'http://download.bioinformatics.northwestern.edu/gems'

gem 'bundler'
gem 'bcdatabase', "1.0.0"
gem "rails", "2.3.4", :require => nil
# The following gems are necessary for jruby deployment
# gem "activerecord-jdbcpostgresql-adapter", "0.9.2"
# gem "jdbc-postgres", "8.3.604"
# gem "jruby-openssl", "0.7.2"
gem "builder", "2.1.2"
gem "calendar_date_select", "1.15"
gem "highline", "1.6.1"
gem 'pg'
gem "rake", "0.8.7"
gem "rubycas-client", "2.1.0"
gem "will_paginate", "2.3.11"
gem "surveyor"

group :development do
  gem 'capistrano'
end

group :test do
  # bundler requires these gems while running tests
  gem 'rspec', '1.3.0'
  gem 'rspec-rails', '1.3.2'
  gem "factory_girl", '1.2.4'
end