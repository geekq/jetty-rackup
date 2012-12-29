# See also the pull request https://github.com/geekq/jetty-rackup/pull/4

# This example does not work with jruby-rack-1.1.2 but works with jruby-rack-1.1.12
# Returns Error 354 in Chrome (net::ERR_CONTENT_LENGTH_MISMATCH)
require 'sinatra/base'

class TestIssue4 < Sinatra::Base
  get '/' do
    halt 400, 'test'
  end

  get '/works' do
    'Always works'
  end
end

