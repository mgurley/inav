require 'casclient'
require 'casclient/frameworks/rails/filter'
options = YAML::load_file(RAILS_ROOT+'/config/cas.yml')
CASClient::Frameworks::Rails::Filter.configure(options[RAILS_ENV])