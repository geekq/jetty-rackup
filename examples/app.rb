get '/?' do
  'hello'
end

get '/:message/?' do
  "hello #{message}"
end
