require 'sinatra'

# If you want to have auto reload in development mode (what is sweet)
# you can uncomment this following lines:
#
# configure :development do
#   Sinatra::Application.reset!  # to reload routes and its contents
#   use Rack::Reloader           # to reload required every files
# end

get '/some' do
  import 'Some'  # using import
  
  some = Some.new
  "From WEB-INF/classes: #{some.say}"
end

get '/other' do
  other = Java::Other.new  # or directly by the Java "namespace"
  "From WEB-INF/lib: #{other.say}"
end
