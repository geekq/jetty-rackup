require 'rubygems'
require 'app'

set :run, false   # disable built-in sinatra web server
set :environment, :development

run Sinatra::Application