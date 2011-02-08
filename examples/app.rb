get '/?' do
  'hello'
end

get '/:message/?' do |message|
  "hello #{message}"
end
