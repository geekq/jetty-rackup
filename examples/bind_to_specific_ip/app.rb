require 'sinatra'

get '/?' do
  "hello from root url"
end

get '/:message/?' do |message|
  "Hello #{message}"
end
