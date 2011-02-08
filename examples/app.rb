require 'sinatra'

# If you want to have auto reload in development mode (what is sweet)
# you can uncomment this following lines:
#
# configure :development do
#   Sinatra::Application.reset!  # to reload routes and its contents
#   use Rack::Reloader           # to reload required every files
# end

get '/?' do
  "hello"
end

get '/:message/?' do |message|
  "hello #{message}"
end
